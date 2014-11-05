self.on("click",function(node,data){
	var testlink = node;
	self.postMessage(node.getAttribute("href"));
});

