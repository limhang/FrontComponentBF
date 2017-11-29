////////////////////////////////////////学习笔记////////////////////////////////////////

////////////////////////////////////////组件简介////////////////////////////////////////
/**
  简介：最简单的select滑轮选择器
  依赖：视图的淡入和淡出，依赖react-transition-group包
  -- 被动输入端：
  * 1.style属性，可配置最外层view的显示
  * 2.children属性，可配置遮罩层上的view
  -- 主动输出端：
  * 1.others属性，支持点击视图，回调函数
**/

////////////////////////////////////////使用代码////////////////////////////////////////
/**
    <Select
      options={[1,2,3,4,5,6,7,8,9,10,11,12,13]}
      selectedindex={7}
      onChange={(index) => {
				console.log(index);
			}} />
**/


////////////////////////////////////////源文件////////////////////////////////////////
import React from 'react';
import PropTypes from 'prop-types';
import {classNames} from '../utils';
import './style.scss';
var Iscoll = require('../iscroll');  //由于iscoll这个库，是使用es5的方式，所以我尝试用es5的方式导入这个库

//容易修改的全局变量
const height = 34;
const maskStyle = {height: (height * 3 + 'px')};
const optionStyle = {
  height: (height + 'px'),
  lineHeight: (height + 'px')
};

//这个组件不需要使用state，但是需要使用组件加载的状态过程的钩子函数，所以还是选用class extends的方式
export default class Select extends React.Component {
  //我们复习es6语法知道，es6对象扩展，其实是语法糖，其实还是构造函数
  //我们在constructor中写的其实是call父对象和自定义属性，那么在外面的函数其实自己的原型函数，在外面的属性对象其实是该构造函数变量

  // Iscoll 实例
  // let iscroller = null;

  constructor(props) {
    super(props);
    this.iscroller = null;
  }

  render() {
    let {options,style,...others} = this.props;
    options = ['', '', ''].concat(options).concat(['', '', '']);
    //设置最外层的滚动视图的高度，这个是一定要设置的，不然滚动视图会失效，其中height是外部定义的变量
    //其实每个文件还是一个作用域的
    style = {...style, height: (height * 7 + 'px')};
    //返回的jsx，node
    return (
      <div ref='wrapper' className={'select'} style={style} {...others}>
      <ul className={classNames('select-options')}>
        {options.map((option, index) => {
          let name = typeof option === 'object' ? option.name : option;
          let key = index + '@-@' + name;
          return (<li key={key} style={optionStyle}>{name}</li>);
        })}
      </ul>
        <div style={maskStyle} className={classNames('select-mask-top')}></div>
        <div style={maskStyle} className={classNames('select-mask-bottom')}></div>
      </div>
    );
  }

  //组件生命周期的钩子函数
  componentDidMount() {
    let {
      iscrollOptions,
      onChange
    } = this.props;
    let {wrapper} = this.refs;
    // fuck a bug
    setTimeout(() => {
      this.iscroller = new Iscoll(wrapper, {
        probeType: 2,  // 默认值
        ...iscrollOptions
      });

      this.iscroller.on('scrollEnd', () => {
        //hookNewY 函数好像失效了所以我在这里处理
        this.iscroller.scrollTo(0, resetYLocation(this.iscroller.y));
        let index = Math.abs(this.iscroller.y / height);
        onChange && onChange(index);
      });

      // 通过 hookNewY 修改滚动位置
      let resetYLocation = (newY) => {
        // Math.ceil(-8.74) = -8
        // 所以已经 -1 了
        let index = Math.ceil(newY / height);

        //这里处理一个bug，当滑动到最后一个的时候就直接返回吧
        if (-index == (this.props.options.length-1)) {
          return newY;
        }

        if (Math.abs(this.iscroller.distY) > (height / 2)) {
          if (this.iscroller.directionY === 1) {
            index -= 1;
          }
        }

        newY = index * height;

        return newY;
      };

      this.resetPosition();

      // 阻止默认事件
      wrapper.addEventListener('touchmove', (e) => {
        e.preventDefault();
      });
    }, 0);
  }

  shouldComponentUpdate(nextProps) {
    return true;
  }

  componentDidUpdate() {
    this.iscroller.refresh();
    this.resetPosition();
  }

  resetPosition() {
    let {selectedindex} = this.props;
    // 定位到指定的 selectIndex
    this.iscroller.scrollTo(0, (-selectedindex * height));
  }

}


Select.propTypes = {
  options: PropTypes.array.isRequired,
  selectedindex: PropTypes.number,
  onChange: PropTypes.func,
  iscrollOptions: PropTypes.object,
  className: PropTypes.string,
  style: PropTypes.object
};

Select.defaultProps = {
  selectedindex: 0
};
