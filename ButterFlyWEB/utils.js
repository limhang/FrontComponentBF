/**
  1.数组解构学习，...args，其中的args一定是一个数组
**/

////////////////////////////////////////文件说明////////////////////////////////////////
import {render} from 'react-dom';
import React from 'react';

/**
 * 包装返回 className
 * @param  {string|object} args 要被包装的 className
 * 所有 className 都会被加上项目的 namespace 前缀。
 * 如果参数是对象，则其属性是 class 名，值为 true 则该 class 名被返回。
 * 如果参数的属性是 `_user` 则直接返回其值，不作包装
 * @return {string}         一个或多个 class。例如："class1 class2 class3"
 *
 * @example
 * let classes = classNames('dialog', {
 *   'dialog-btn': false,
 *   'dialog-title': true,
 *   '_user': 'user-class'
 * });
 * console.log(classes);
 * // 假设 namespace='rd'
 * // output: "rc-dialog rc-dialog-title user-class"
 */

 const hasOwn = {}.hasOwnProperty;
 //...args，是数组的扩展，args一定是一个数组
 export function classNames(...args) {
   //classes保存修改后的数组元素
  let classes = [];
  let arg, argType, key;

  for (let i = 0, len = args.length; i < len; i++) {
    arg = args[i];
    //typeof类型检测
    argType = typeof arg;

    if (!arg) continue;
    //多种类型的数据，多种处理，1.如果是字符或者是数值，直接添加到数组；2.如果是数组，直接递归下自己；3.如果是对象，取出key值
    if (argType === 'string' || argType === 'number') {
      prePush(classes, arg);
    } else if (Array.isArray(arg)) {
      //这个是es5时代的写法，我们仔细想想，我们调用classNames这个函数传递进去的，应该是多个对象，
      //然后通过...args，对象扩展，参数就变成了数组，所以在es5时代，将数组打散做成对象，使用apply方法
      //在es6时代，我们可以直接使用数组扩展，classNames(...arg)
      classes.push(classNames.apply(null, arg));  // 等同于 classes.push(classNames(...arg));
    } else if (argType === 'object') {
      for (key in arg) {
        //第一个判断是看下这个属性是否存在(其实有点多余)，第二个判断是看下key的value是否为false
        if (!hasOwn.call(arg, key) || !arg[key]) continue;

        // 用户传入的
        if (key === '_user') {
          classes.push(arg[key]);
        } else {
          prePush(classes, key);
        }
      }
    }
  }
  //数组方法，将元素加上空格符
  return classes.join(' ');
}

function prePush(arr, value) {
  // value = `${namespace}-${value}`;
  return arr.push(value);
}



/**
 * 根据传入的 Component 创建一个实例，并渲染到 container
 * @param  {Component} Component React 组件
 * @param  {node} container 实例将渲染到该 dom 节点，
 * 如果缺少，内部创建 dom 节点。
 * @return {PropTypes.element}           Component 的实例
 */
export function createInstance(Component, container) {
  if (!container) {
    container = createContainer();
  }

  return render(<Component />, container);
}

/**
 * 创建一个 dom 节点，div.${namespace}-apicontainer
 * @return {dom} 节点
 */
function createContainer() {
  let div = document.createElement('div');
  div.className = classNames('api-container');
  document.body.appendChild(div);

  return div;
}
