// Custom filter can be used like "| currency: '$'"
ko.filters.currency = function(value, arg1) {
    if (_.isNull(value)) return '';
    return (arg1||'€') + ' ' + ko.utils.unwrapObservable(value).toFixed(2)
};
