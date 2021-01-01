package router

import (
	"blog/conf"
	"blog/control"
	"log"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"

)

// RunApp 入口
func RunApp() {
	engine := echo.New()
	if conf.App.Tls {
		engine.Pre(middleware.HTTPSRedirect()) //使用重定向中间件将http连接重定向到https
	}
	engine.Renderer = initRender()                    // 初始渲染引擎
	engine.Use(midRecover, midLogger)                 // 恢复 日志记录
	engine.Use(middleware.CORSWithConfig(crosConfig)) // 跨域设置
	engine.HideBanner = true                          // 不显示横幅
	engine.HTTPErrorHandler = HTTPErrorHandler        // 自定义错误处理
	engine.Debug = conf.App.IsDev()                   // 运行模式 - echo框架好像没怎么使用这个
	RegDocs(engine)                                   // 注册文档
	engine.Static(`/dist`, "dist")                    // 静态目录 - 后端专用
	engine.Static(`/static`, "static")                // 静态目录
	engine.Static(`/.well-known`, ".well-known")      // acme.sh验证用
	engine.File(`/favicon.ico`, "favicon.ico")        // ico
	engine.File("/dashboard*", "dist/index.html")     // 前后端分离页面

	//--- 页面 -- start
	engine.GET(`/`, control.IndexView)                 // 首页
	engine.GET(`/archives`, control.ArchivesView)      // 归档
	engine.GET(`/search`, control.SearchView)          // 搜索
	engine.GET(`/archives.json`, control.ArchivesJson) // 归档 json
	engine.GET(`/tags`, control.TagsView)              // 标签
	engine.GET(`/tags.json`, control.TagsJson)         // 标签 json
	engine.GET(`/tag/:tag`, control.TagPostView)       // 具体某个标签
	engine.GET(`/cate/:cate`, control.CatePostView)    // 分类
	engine.GET(`/about`, control.AboutView)            // 关于
	engine.GET(`/links`, control.LinksView)            // 友链
	engine.GET(`/post/*`, control.PostView)            // 具体某个文章
	engine.GET(`/page/*`, control.PageView)            // 具体某个页面
	//--- 页面 -- end

	api := engine.Group("/api")         // api/
	apiRouter(api)                      // 注册分组路由
	adm := engine.Group("/adm", midJwt) // adm/ 需要登陆才能访问
	admRouter(adm)                      // 注册分组路由
	var err error

	if conf.App.Tls {
		err = engine.StartTLS(conf.App.Addr, conf.App.Https.Crt, conf.App.Https.Key)
	} else {
		err = engine.Start(conf.App.Addr)
	}

	if err != nil {
		log.Fatalln("run error :", err)
	}
}
