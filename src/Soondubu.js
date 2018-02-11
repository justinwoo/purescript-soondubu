var Chart = require('chart.js');

exports.makeBarChart_ = function (spec) {
  return function (context) {
    return function () {
      return new Chart.Bar(context, spec);
    };
  };
};
