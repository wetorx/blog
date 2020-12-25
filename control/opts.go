package control

import (
	"blog/model"

	"github.com/labstack/echo/v4"
	"github.com/zxysilent/utils"

)

// OptsGet 获取某个配置项
func OptsGet(ctx echo.Context) error {
	key := ctx.Param("key")
	if key == "" {
		return ctx.JSON(utils.ErrIpt(`请填写key值`))
	}
	if val, ok := model.OptsGet(key); ok {
		return ctx.JSON(utils.Succ(``, val))
	}
	return ctx.JSON(utils.ErrIpt(`错误的key值`))
}

// OptsEdit 编辑某个配置项
func OptsEdit(ctx echo.Context) error {
	ipt := &model.Opts{}
	err := ctx.Bind(ipt)
	if err != nil {
		return ctx.JSON(utils.ErrIpt(`数据输入错误,请重试`, err.Error()))
	}
	if !model.OptsEdit(ipt) {
		return ctx.JSON(utils.Fail(`配置项修改失败`))
	}
	return ctx.JSON(utils.Succ(`配置项修改成功`))
}

// OptsBase 基本配置项目
func OptsBase(ctx echo.Context) error {
	// ipt := &model.Opts{}
	// err := ctx.Bind(ipt)
	// if err != nil {
	// 	return ctx.JSON(utils.ErrIpt(`数据输入错误,请重试`, err.Error()))
	// }
	// if !model.OptsEdit(ipt) {
	// 	return ctx.JSON(utils.Fail(`配置项修改失败`))
	// }
	mp := model.MapOpts
	// delete(mp, "analytic")
	// delete(mp, "comment")
	return ctx.JSON(utils.Succ(`基本配置项目`, mp))
}

// OptsPrivateGet 获取某个私有配置项
func OptsPrivateGet(ctx echo.Context) error {
	key := ctx.Param("key")
	if key == "" {
		return ctx.JSON(utils.ErrIpt(`请填写key值`))
	}
	if val, ok := model.OptsKeyGet(key); ok {
		return ctx.JSON(utils.Succ(``, val))
	}
	return ctx.JSON(utils.ErrIpt(`错误的key值`))
}

// OptsPrivateEdit 编辑某个私有配置项
func OptsPrivateEdit(ctx echo.Context) error {
	ipt := &model.OptsKey{}
	err := ctx.Bind(ipt)
	if err != nil {
		return ctx.JSON(utils.ErrIpt(`数据输入错误,请重试`, err.Error()))
	}
	if !model.OptsKeyEdit(ipt) {
		return ctx.JSON(utils.Fail(`私有配置项修改失败`))
	}
	return ctx.JSON(utils.Succ(`私有配置项修改成功`))
}

// OptsPrivate 私有配置项目
func OptsPrivate(ctx echo.Context) error {
	mp := model.MapOptsKey
	return ctx.JSON(utils.Succ(`私有配置项目`, mp))
}
