function add_item(text) {
  var content = document.createTextNode(text); 
  var item = document.createElement('li')
  var list = document.getElementById('tutorial-list')
  item.appendChild(content)
  list.appendChild(item)
  return list.childElementCount
}

function load_image_return_size() {
  var image = document.createElement('img')
  var images = document.getElementById( 'tutorial-images' )
  images.appendChild(image)
  image.src = 'file:///android_res/drawable/get_ruboto_core.png'
  return { 'width': image.width, 'height': image.height }
}

function remove_image() {
  var images = document.getElementById( 'tutorial-images' )
  images.removeChild(images.lastChild)
}

function json_arg(j) {
  jsi.json_arg(JSON.stringify(j))
}

function collect_inputs() {
  var cols = ['hleft', 'hright', 'fleft', 'fright'];
  var inputs = {};

  cols.forEach(function(col) {
    Array(6).fill().map((_, i) => { inputs[col+'_'+(i+1)] = $('#'+col+'_'+(i+1)).val(); });
  });

  return inputs;
}

function fill_inputs(inputs) {
  var cols = ['hleft', 'hright', 'fleft', 'fright'];

  cols.forEach(function(col) {
    Array(6).fill().map((_, i) => { $('#'+col+'_'+(i+1)).val(inputs[col+'_'+(i+1)]); });
  });
}

$(function() {
  $('#inputform').on('keyup', 'input', function (event) {
    if (event.which == 13) {
      event.preventDefault();
      var $this = $(event.target);
      var index = parseFloat($this.attr('tabindex'));

      var next = $('[tabindex="' + (index + 1).toString() + '"]');
      if (next.length) {
        next.focus();
      } else {
        $('#calculations').css('display', 'block');
        var calculations = JSON.parse(jsi.calculate());

        Object.keys(calculations).forEach(function (key) { 
          var value = calculations[key];
          $('#'+key).text(value);
        });
      }
    }

    json_arg(collect_inputs());
  });

  fill_inputs(JSON.parse(jsi.json_arg_return()));
});
