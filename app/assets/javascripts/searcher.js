$(document).on('turbolinks:load', function() {
  return $('#product_id').select2({
    ajax: {
      url: '/products',
      data: function(params) {
        return {
          name: params.term
        };
      },
      dataType: 'json',
      delay: 500,
      processResults: function(data, params) {
        return {
          results: _.map(data, function(el) {
            return {
              id: el.id,
              name: el.name + ", $" + el.price
            };
          })
        };
      },
      cache: true
    },
    escapeMarkup: function(markup) {
      return markup;
    },
    minimumInputLength: 1,
    templateResult: function(item) {
      return item.name;
    },
    templateSelection: function(item) {
      return item.name;
    },
    theme: "bootstrap"
  });
});