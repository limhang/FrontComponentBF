//js，react语法上的坑还是比较多的，既然，我是在一边学习js,react语法，一边封装下view层，那么在此做下学习js,react的坑

/*  -- 封装该组件学习笔记
	1.import是es6的语法，在导入该js文件的时候，由于导出众多，所以需要使用import {NormalTopImgBottomLab} from './NormalTopImgBottomLab.js'，
	而不能，直接使用import NormalTopImgBottomLab from './NormalTopImgBottomLab.js'。
	2.div等html元素设置点击事件，使用onClick，在jsx中写入js代码，需要加上大括号，所以使用onClick={callback}，这里又有一个错误，我们只需要制定这个函数，
	不需要调用它，不能写成onClick={callback()}。
*/


/*  -- 该组件使用
	心得：
	1、其实web组件，iOS组件还是有很多不同点的，web组件【被动输入】，更多的依赖，输入端修改classname的值，变换样式
	web组件【主动输出】，依赖于props回调函数。
	2、无状态组件，一般都是很纯粹很简单的组件，没有state做内部状态切换，那么组件样式什么的改变，只能依赖于外界，【props属性，自己无法改变自己】
	简介：上面是一个图片，下面是文字，最简单的UI组件
	主动输出：点击事件回调输出 -- clickCallBack
	被动输入：
	1
*/

import React from 'react';
import {classNames} from '../utils';
import './NormalTopImgBottomLab.scss';
import PropTypes from 'prop-types';

export function NormalTopImgBottomLab(props) {
	let {clickCallBack,name,type } = props;
	let className = classNames('NormalTopImgBottomLab',{
		[`NormalTopImgBottomLab-${type}`] : true
	});
	return <h1 className={className} onClick={clickCallBack}>{name}</h1>;
}

NormalTopImgBottomLab.propTypes = {
	name: PropTypes.string,
	theme: PropTypes.oneOf(['warning','theme'])
}
