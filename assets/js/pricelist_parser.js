var $table;
$(function()
{
	writeJSON();
	$table = $("#buylist");
	loadData();
	$("#reload").click(function()
	{
		loadData();
	});
});
function loadData()
{
	$.ajax({
	    url: "http://backpack.tf/api/IGetPrices/v4/?key=542dfd5dba8d88df3e8b494c&format=jsonp",
	    format: "jsonp",
	    dataType: "JSONP",
	    jsonpCallback: "jsonCallback",
	    type: "GET",
	    success: function (data) {
	        if(data.response.success == 0)
	        {
	        	if(!isNaN(parseInt(data.response.message.substring(74, 76))))
	        	{
		        	var secondsLeft = parseInt(data.response.message.substring(74, 76));
		        	console.log("Failed to load. Try again in " + secondsLeft + " seconds.");
		        	alert("Failed to load. Try again in " + secondsLeft + " seconds.");
	       		}
	       		else
	       		{
	       			console.log("Failed to load. Please try again later.");
	       			alert("Failed to load. Please try again later.");
	       		}
	        }
	        else
	        {
	        	$table.empty();
		        $.each(data.response.items, function(name, item)
		        {
		        	if(item.prices[11] != undefined)
		        	{
		        		if(item.prices[11].Tradable != undefined)
		        		{
		        			if(item.prices[11].Tradable.Craftable[0].currency == "metal")
		        			{
			        			// console.log(name + ": " + item.prices[11].Tradable.Craftable[0].value);
			        			$table.append("<tr><td>Strange " + name + "</td><td>" + item.prices[11].Tradable.Craftable[0].value + " Refined Metal</td></tr>")
		        			}
		        		}
		        	}
		        });
	    	}
	    }
	});
}

function writeJSON()
{
	console.log('hi');
	var fh = fopen("pricelist.txt", 3); // Open the file for writing
	if(fh!=-1) // If the file has been successfully opened
	{
		console.log('sweg');
		var str = "Some text goes here...";
		fwrite(fh, str); // Write the string to a file
		fclose(fh); // Close the file 
	}
	else
	{
		console.log('fuk');
	}
}