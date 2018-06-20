$(document).ready(function() {
  Trix.config.attachments.preview.caption = {
    name: false,
    size: false
  };

  function uploadAttachment(attachment) {
    debugger;
    var csrfToken = $('meta[name="csrf-token"]').attr('content');
    var file = attachment.file;
    var form = new FormData;
    var endpoint = "/assets/images"; // Use for local save
    form.append("Content-Type", file.type);
    form.append("image[image]", file);

    xhr = new XMLHttpRequest;
    xhr.open("POST", endpoint, true);
    xhr.setRequestHeader("X-CSRF-Token", csrfToken);

    xhr.upload.onprogress = function(event) {
      var progress = event.loaded / event.total * 100;
      return attachment.setUploadProgress(progress);
    };

    xhr.onload = function() {
      if (this.status >= 200 && this.status < 300) {
        var data = JSON.parse(this.responseText);
        return attachment.setAttributes({
          url: data.url,
          href: data.url
        });
      }
    };

    return xhr.send(form);
  };

  document.addEventListener("trix-attachment-add", function(event) {
    debugger;
    var attachment = event.attachment;
    if (attachment.file) {
      return uploadAttachment(attachment);
    }
    else {
      attachment.remove();
    }
  });
});

