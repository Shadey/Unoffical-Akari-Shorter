// This is an active module of the Shadey (1) Add-on
exports.main = function() {
var Request = require("sdk/request").Request;
var contextMenu = require("sdk/context-menu");
var notifications = require("sdk/notifications");
var clipboard = require("sdk/clipboard");
var clickedlink = contextMenu.Item({
  label: "Akarin~ Shorten This Link",
    context: contextMenu.SelectorContext("a[href]"),
    contentScript: 'self.on("click", function (node,data) {' +
                 '  self.postMessage(node.baseURI);' +
                 '});',
  onMessage: function (link) {
    var links = Request({
  url: "http://api.waa.ai/?url="+link,
  onComplete: function (response) {
    notifications.notify({
          title: "Waa.ai",
          text: response.text,
        });
    clipboard.set(response.text);
    console.log(response.text);
  }});
    links.get();
  }});
  
  
 var pagelink = contextMenu.Item({
  label: "Akarin~ Shorten This Page",
    context: contextMenu.PageContext(),
    contentScript: 'self.on("click", function (node,data) {' +
                 '  self.postMessage(document.URL);' +
                 '});',
  onMessage: function (page) {
    console.log(page);
    var pagelinks = Request({
  url: "http://api.waa.ai/?url="+page,
  onComplete: function (response) {
    notifications.notify({
          title: "Waa.ai",
          text: response.text,
        });
    clipboard.set(response.text);
    console.log(response.text);
  }});
  pagelinks.get();
  }});
  
   var imagelink = contextMenu.Item({
  label: "Akari~ Shorten Image URL",
    context: contextMenu.SelectorContext("img"),
    contentScript: 'self.on("click", function (node,data) {' +
                 '  self.postMessage(node.src);' +
                 '});',
  onMessage: function (image) {
    console.log(image);
    var imagelinks = Request({
  url: "http://api.waa.ai/?url="+image,
  onComplete: function (response) {
    notifications.notify({
          title: "Waa.ai",
          text: response.text,
        });
    clipboard.set(response.text);
    console.log(response.text);
  }});
  imagelinks.get();
  }});
};