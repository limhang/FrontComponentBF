import * as _ from "./utils";
import * as Keep from "./Keep";
import {mix as mixer} from "./mixer";
import {bindMethods} from "./bindMethods";
import * as StoreMethods from "./StoreMethods";
import * as PublisherMethods from "./PublisherMethods";
import * as ListenerMethods from "./ListenerMethods";

var allowed = { preEmit: 1, shouldEmit: 1 };

/**
 * Creates an event emitting Data Store. It is mixed in with functions
 * from the `ListenerMethods` and `PublisherMethods` mixins. `preEmit`
 * and `shouldEmit` may be overridden in the definition object.
 *
 * @param {Object} definition The data store object definition
 * @returns {Store} A data store instance
 */
 //传进来的方法
export function createStore(definition) {

    definition = definition || {};

    //判断不能有和storeMethods中重名的方法，这个在基本使用中用不上，因为我们不需要写storeMethods和actionMethods方法
    for(var a in StoreMethods){
        if (!allowed[a] && (PublisherMethods[a] || ListenerMethods[a])){
            throw new Error("Cannot override API method " + a +
                " in Reflux.StoreMethods. Use another method name or override it on Reflux.PublisherMethods / Reflux.ListenerMethods instead."
            );
        }
    }

//提取definition中的方法名，命名为变量d
    for(var d in definition){
        //判断是否有和publish，listen重名的情况，这个就像下面throw写的一样，不能和api的接口重名
        if (!allowed[d] && (PublisherMethods[d] || ListenerMethods[d])){
            throw new Error("Cannot override API method " + d +
                " in store creation. Use another method name or override it on Reflux.PublisherMethods / Reflux.ListenerMethods instead."
            );
        }
    }

    definition = mixer(definition);

    function Store() {
        var i = 0, arr;
        this.subscriptions = [];
        this.emitter = new _.EventEmitter();
        this.eventLabel = "change";
        bindMethods(this, definition);
        if (this.init && _.isFunction(this.init)) {
            this.init();
        }
        if (this.listenables){
            arr = [].concat(this.listenables);
            for(; i < arr.length; i++){
                this.listenToMany(arr[i]);
            }
        }
    }

    _.extend(Store.prototype, ListenerMethods, PublisherMethods, StoreMethods, definition);

    var store = new Store();
    Keep.addStore(store);

    return store;
}
