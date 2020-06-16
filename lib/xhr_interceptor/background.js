console.log(123312)

var onCompleted_callback = function(details) {
	if (details.type == 'xmlhttprequest') {
		console.log(details)
	}
	return {};
	debugger;
}

chrome.webRequest.onCompleted.addListener(
	onCompleted_callback,
	{urls: ["<all_urls>"]},
	["responseHeaders"]
);