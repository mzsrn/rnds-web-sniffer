(function(xhr) {

  var XHR = XMLHttpRequest.prototype;

  var open = XHR.open;
  var send = XHR.send;

  XHR.open = function(method, url) {
    this._method = method;
    this._url = url;
    this._requestHeaders = {};
    this._startTime = (new Date()).toISOString();

    return open.apply(this, arguments);
  };

  XHR.send = function(postData) {

    this.addEventListener('load', function() {
      var myUrl = this._url ? this._url.toLowerCase() : this._url;
      if(myUrl) {

        if ( this.responseType != 'blob' && this.responseText) {
          try { 
            if (decodedJSON = JSON.parse(this.responseText)) {
              console.log(decodedJSON) 
            } else if (decodedBase64 = atob(this.responseText)) {
              console.log(decodedBase64) 
            }
          } catch { console.log(`UNPARSED RESPONSE: ${this.responseText}`) }
        }

      }
    });

    return send.apply(this, arguments);
  };

})(XMLHttpRequest);  