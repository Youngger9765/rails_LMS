import Sortable from 'sortablejs';
import Rails from '@rails/ujs';

document.addEventListener('turbolinks:load', () => {
  let el = document.querySelector('.sortable-items');
  if (el) {
    Sortable.create(el, {
      onEnd: event => {
        let [model_name, id] = event.item.dataset.item.split('_');
        let url = '/admin/' + model_name + '/sort';
        let data = new FormData();
        data.append("id", id);
        data.append("form", event.oldIndex);
        data.append("to", event.newIndex);
        Rails.ajax({
          url: url,
          type: 'PUT',
          data: data,
          success: function(data) {
            console.log(data);
          },
          error: function(data) {
            console.log(data);
          }
        });
      }
    })
  }
});