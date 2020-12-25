import fetch from "./fetch";
// 获取基本配置项
export const apiOptsBase = () => {
	return fetch.get(`/api/opts/base`);
};
// 获取某个配置项
export const apiOptsGet = key => {
	return fetch.get(`/api/opts/${key}`);
};
// 编辑某个配置项
export const admOptsEdit = data => {
	return fetch.post("/adm/opts/edit", data);
};

// 获取私有配置项
export const admOptsPrivate = () => {
	return fetch.get(`/adm/optsp/private`);
};
// 获取某个私有配置项
export const admOptsPrivateGet = key => {
	return fetch.get(`/adm/optsp/${key}`);
};
// 编辑某个私有配置项
export const admOptsPrivateEdit = data => {
	return fetch.post("/adm/optsp/edit", data);
};