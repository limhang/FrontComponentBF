/*  -- 封装该组件学习笔记
	1.如果在export的时候使用export default，那么在引入import的时候，就要使用import xxx from yyy;
	如果export的时候没有使用default，那么在引入import的时候，就要使用import {xxx} from yyy。
*/

/**
	简介：箭头勾符号，支持配置这个图标的大小（由于使用的是i），可支持多种style内嵌输入
	-- 被动输入端：
	* 1.style属性，可配置的输入属性，对象
	* 2.size属性，可配置显示的大小
	-- 主动输出端：
	* 1.点击回调函数
**/
import React from 'react';
import PropTypes from 'prop-types';
import {classNames} from '../utils';
import './style.scss';

export default function IconCheck(props) {
	let {clickCallBack,style,size } = props;
	let className = classNames('icon-check');
	style = {
		...style,
		height: size,
		width: size,
		fontSize: size
	};
	return (
		<i className={className} style={style}/>
	)
}


//属性默认值
IconCheck.defaultProps = {
  size: '40px'
};


//组件的类型检查
IconCheck.propTypes = {
  size: PropTypes.string,
  style: PropTypes.object
};
