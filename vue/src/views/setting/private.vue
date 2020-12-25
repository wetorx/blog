
<template>
	<Card dis-hover>
		<p slot="title">
			<Icon type="ios-settings-outline" /> 基本设置
		</p>
		<div style="max-width:600px">
			<Form ref="optsPrivate" :model="optsPrivate" label-position="top" :rules="optsPrivate">
				<FormItem label="AccessKey" prop="kuaiyun_accesskey">
					<Input v-model="optsPrivate.kuaiyun_accesskey" search enter-button="确    定" @on-search="cmtSave('kuaiyun_accesskey')"></Input>
				</FormItem>
			</Form>
			<Form ref="optsPrivate" :model="optsPrivate" label-position="top" :rules="optsPrivate">
				<FormItem label="SecretKey" prop="kuaiyun_secretkey">
					<Input v-model="optsPrivate.kuaiyun_secretkey" search enter-button="确    定" @on-search="cmtSave('kuaiyun_secretkey')"></Input>
				</FormItem>
			</Form>
			<Form ref="optsPrivate" :model="optsPrivate" label-position="top" :rules="optsPrivate">
				<FormItem label="用户凭证" prop="kuaiyun_voucher">
					<Input v-model="optsPrivate.kuaiyun_voucher" search enter-button="确    定" @on-search="cmtSave('kuaiyun_voucher')"></Input>
				</FormItem>
			</Form>
			<Form ref="optsPrivate" :model="optsPrivate" label-position="top" :rules="optsPrivate">
				<FormItem label="调用来源" prop="kuaiyun_resource">
					<Input v-model="optsPrivate.kuaiyun_resource" search enter-button="确    定" @on-search="cmtSave('kuaiyun_resource')"></Input>
				</FormItem>
			</Form>
			<Form ref="optsPrivate" :model="optsPrivate" label-position="top" :rules="optsPrivate">
				<FormItem label="空间名" prop="kuaiyun_bucketname">
					<Input v-model="optsPrivate.kuaiyun_bucketname" search enter-button="确    定" @on-search="cmtSave('kuaiyun_bucketname')"></Input>
				</FormItem>
			</Form>
			<Form ref="optsPrivate" :model="optsPrivate" label-position="top" :rules="optsPrivate">
				<FormItem label="上传目录" prop="kuaiyun_cloudpath">
					<Input v-model="optsPrivate.kuaiyun_cloudpath" search enter-button="确    定" @on-search="cmtSave('kuaiyun_cloudpath')"></Input>
				</FormItem>
			</Form>
			<Form ref="optsPrivate" :model="optsPrivate" label-position="top" :rules="optsPrivate">
				<FormItem label="绑定域名" prop="kuaiyun_domain">
					<Input v-model="optsPrivate.kuaiyun_domain" search enter-button="确    定" @on-search="cmtSave('kuaiyun_domain')"></Input>
				</FormItem>
			</Form>
		</div>
	</Card>
</template>
<script>
import { admOptsPrivate, admOptsPrivateEdit } from "@/api/opts";
export default {
	data() {
		return {
			optsPrivate: {},
			saveLoading: false
		};
	},
	methods: {
		cmtSave(key) {
			this.save_loading = true;
			admOptsPrivateEdit({
				key: key,
				value: this.optsPrivate[key]
			}).then(resp => {
				this.saveLoading = false;
				if (resp.code == 200) {
					this.$Message.success({ content: "更新成功" });
				} else {
					this.$Message.error({
						content: `更新失败`,
						duration: 3,
						onClose() {
							this.init();
						}
					});
				}
			});
		},
		init() {
			admOptsPrivate().then(resp => {
				if (resp.code == 200) {
					this.optsPrivate = resp.data;
				} else {
					this.optsPrivate = {};
				}
			});
		},
	},
	mounted() {
		this.init();
	}
};
</script>
