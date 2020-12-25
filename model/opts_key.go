package model

import "github.com/zxysilent/logs"

// OptsKey 配置
type OptsKey struct {
	Key   string `xorm:"not null pk  unique VARCHAR(64)"`
	Value string `xorm:"not null  VARCHAR(2048)"`
	Intro string `xorm:"not null  VARCHAR(255)"`
}

//MapOptsKey 数据库配置信息
var MapOptsKey mapOpts

func initKeyMap() {
	mods := make([]OptsKey, 0, 8)
	Db.Find(&mods)
	m := make(map[string]string, len(mods))
	for _, v := range mods {
		m[v.Key] = v.Value
	}
	MapOptsKey = m
	logs.Debug("opts cache")
}

// OptsKeyGet 获取某个 配置
func OptsKeyGet(key string) (string, bool) {
	return MapOptsKey.Get(key)
}

// OptsKeyMustGet 获取某个 配置
func OptsKeyMustGet(key string) string {
	return MapOptsKey.MustGet(key)
}

// OptsKeyEdit 编辑配置
func OptsKeyEdit(mod *OptsKey) bool {
	sess := Db.NewSession()
	defer sess.Close()
	sess.Begin()
	affect, err := sess.ID(mod.Key).Cols("Value").Update(mod)
	if affect >= 0 && err == nil {
		sess.Commit()
		//	initMap()
		MapOptsKey.Set(mod.Key, mod.Value)
		return true
	}
	sess.Rollback()
	return false
}
