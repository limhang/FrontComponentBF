////////////////////////////////////////学习笔记]////////////////////////////////////////
/**
 *由于鼠标放在其上，会自动下拉出菜单，所以应该有一个字段来处理这个变化的状态
**/
////////////////////////////////////////组件简介////////////////////////////////////////
/**
  简介: web网页中很常见的下拉菜单，鼠标放在其上，就自动下拉出其他可选子项。
  依赖：
  -- 被动输入端：
  * 1.datasource数组，用户提供给我们的显示数组
  -- 主动输出端：
  * 1.用户点击那个item，主动输出给用户
**/

////////////////////////////////////////使用代码////////////////////////////////////////
/**
 <DropMenu dataSource={['亲 人','情 侣','同 学','朋 友','同 事']} itemClick={(index)=>{console.log(index)}}/>
**/

////////////////////////////////////////源文件////////////////////////////////////////
import React from 'react';
import PropTypes from 'prop-types';
import './style.scss';
import {CSSTransitionGroup} from 'react-transition-group' // ES6

const duration = 300;

export default class DropMenu extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        show: false,
        showItemcontent: '分 类',
        style: {paddingLeft: '5px', paddingRight: '5px'}
    }
    this.dropMenuControl = this.dropMenuControl.bind(this);
    this.clickItem = this.clickItem.bind(this);
  }

//控制dropmenu显示和隐藏
  dropMenuControl() {
    this.setState({show: !this.state.show});
    if (this.state.show) {
        setTimeout(()=>{this.setState({style:{paddingLeft: '5px',paddingRight: '5px'}})},duration);
    } else {
        this.setState({style:{}})
    }
  }

  //点击每个item事件
  clickItem(index) {
    this.setState({showItemcontent: this.props.dataSource[index]});
    this.props.itemClick(index);
  }

  render() {
    let {dataSource} = this.props;
    let style = {'transitionDuration': `${duration}ms`};
    return (
      <div className="dropmenu" style={this.state.style} onClick={this.dropMenuControl}>{this.state.showItemcontent}
        <CSSTransitionGroup
          transitionName={'dropmenu-content'}
          transitionEnterTimeout={duration}
          transitionLeaveTimeout={duration}>
          {this.state.show ? <div className="dropmenu-content" style={style}>{dataSource.map((item, index) => {
              return <div className="dropmenu-content-item" key={index} onClick={()=>{this.clickItem(index)}}>{item}</div>
            })}</div> : null}
        </CSSTransitionGroup>
      </div>
    );
  }
}
