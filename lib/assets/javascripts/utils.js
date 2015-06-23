function existy(x) { return x != null };

function cat() {
    var head = _.first(arguments);
    if (existy(head))
        return head.concat.apply(head, _.rest(arguments));
    else
        return [];
}

function checker(/* validators */) {
    var validators = _.toArray(arguments);

    return function (obj) {
        return _.reduce(validators, function (errs, check) {
            if (check(obj))
                return errs
            else
                return _.chain(errs).push(check.message).value();
        }, []);
    };
}

function validator(message, fun) {
    var f = function (/* args */) {
        return fun.apply(fun, arguments);
    };

    f['message'] = message;
    return f;
}

function aMap(obj) {
    return _.isObject(obj);
}

function anArray(obj) {
    return _.isArray(obj);
}

function aFunction(obj) {
    return _.isFunction(obj);
}

function hasKeys() {
    var KEYS = _.toArray(arguments);

    var fun = function (obj) {
        return _.every(KEYS, function (k) {
            return _.has(obj, k);
        });
    };

    fun.message = cat(["Must have values for keys:"], KEYS).join(" ");
    return fun;
}

function must(/*data, cmd*/) {
    var ps = _.toArray(arguments),
		data = ps[0],
		cmd = checker.apply(checker, _(ps).rest(1)),
		errors = cmd(data);

    if (!_.isEmpty(errors)) {
        throw errors.join(". ");
    }
}

/**
 * Mixin Funktionalität.
 */
function mixin(to, from) {
    from.call(to.prototype);
}

require(['jquery'], function ($) {
    /**
		Performs a jQuery ajax request with type "METHOD" and "cache: false". 
	
		@param {string} url The url for the request 
        @param {object} options Add options to $.ajax()
	*/
    $.postJSON = function (url, data, options) {
        function sanitize(d) {
            return _(d).mapObject(function (val, key) {
                return _(val).isFunction()
                    ? val()
                    : val;
            });
        }

        var settings = $.extend(options || {}, {
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            url: url,
            dataType: "json",
            data: JSON.stringify(sanitize(data)),
        });

        return $.ajax(settings);
    }

    /**
		Performs a jQuery ajax json request with global set to false. 
	
		@param {string} url The url for the request 
        @param {object} options Add options to $.ajax()
	*/
    $.silentGetJSON = function (url, data, options) {
        var settings = $.extend(options || {}, {
            type: 'GET',
            contentType: "application/json; charset=utf-8",
            url: url,
            dataType: "json",
            data: data,
            global: false
        });

        return $.ajax(settings);
    }

    /**
     * Add number of days to date
     */
    Date.prototype.addDays = function (days) {
        var dat = new Date(this.valueOf());
        dat.setDate(dat.getDate() + days);
        return dat;
    }
});

