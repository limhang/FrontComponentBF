import * as _ from "./utils";
import * as ActionMethods from "./ActionMethods";
import * as PublisherMethods from "./PublisherMethods";
import * as Keep from "./Keep";

var allowed = { preEmit: 1, shouldEmit: 1 };

/**
 * Creates an action functor object. It is mixed in with functions
 * from the `PublisherMethods` mixin. `preEmit` and `shouldEmit` may
 * be overridden in the definition object.
 *
 * @param {Object} definition The action object definition
 */
export function createAction(definition) {

//如果createAction传入的参数为空，则，definition也为空
    definition = definition || {};
    if (!_.isObject(definition)){
        definition = {actionName: definition};
    }

//这个数组的方法，我没有定义，所以默认也不用管，这里应该和createStore是一样的，提示用户不能覆盖掉api方法
    for(var a in ActionMethods){
        if (!allowed[a] && PublisherMethods[a]) {
            throw new Error("Cannot override API method " + a +
                " in Reflux.ActionMethods. Use another method name or override it on Reflux.PublisherMethods instead."
            );
        }
    }
//传入的方法，不能覆盖掉api的方法
    for(var d in definition){
        if (!allowed[d] && PublisherMethods[d]) {
            throw new Error("Cannot override API method " + d +
                " in action creation. Use another method name or override it on Reflux.PublisherMethods instead."
            );
        }
    }

//js创建对象和数组都用类似的方法，最好学习语言的方式，还是看看大神的代码，和大神的代码靠拢，这个可以加红，如果没有children属性，那么创建一个为空的数组赋值给children属性
    definition.children = definition.children || [];
    //如果没有asyncResult属性，那么直接调过这个代码块
    if (definition.asyncResult){
        definition.children = definition.children.concat(["completed", "failed"]);
    }
//js语言中，声明变量还是有点飘逸，我一时还是适应不了
    var i = 0, childActions = {};
    //children数组为空，直接跳过这个for循环
    for (; i < definition.children.length; i++) {
        var name = definition.children[i];
        childActions[name] = createAction(name);
    }

    var context = _.extend({
        eventLabel: "action",
        emitter: new _.EventEmitter(),
        _isAction: true
    }, PublisherMethods, ActionMethods, definition);


//这里非常的巧妙，functor是一个函数，然后apply之后调用extend之后，publishMethod的tirgger函数
    var functor = function() {
        var triggerType = functor.sync ? "trigger" : "triggerAsync";
        return functor[triggerType].apply(functor, arguments);
    };

//
    _.extend(functor, childActions, context);

    Keep.addAction(functor);
//返回的是一个函数
    return functor;

}
