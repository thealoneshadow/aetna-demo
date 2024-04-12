pip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainpip install langchainvar worksheet;

viz.getWorkbook().activateSheetAsync("Sheet 4").then(function (sheet) {
  worksheet = sheet;
})
// Single value
.then(function () {
  return worksheet.applyFilterAsync("Product Type", "Coffee",
    tableau.FilterUpdateType.REPLACE);
})
// Multiple values
.then(function () {
  return worksheet.applyFilterAsync(
    "Product Type", ["Coffee", "Tea"],
    tableau.FilterUpdateType.REPLACE);
})
// Multiple Values - adding and removing
.then(function () {
  return worksheet.applyFilterAsync("Product", ["Lemon", "Mint"],
    tableau.FilterUpdateType.ADD);
})
.then(function () {
  return worksheet.applyFilterAsync("Product", ["Caffe Latte", "Green Tea"],
    tableau.FilterUpdateType.REMOVE);
})
// All values
.then(function () {
  return worksheet.applyFilterAsync("Product Type", "",
    tableau.FilterUpdateType.ALL);
})
// Date Range
.then(function () {
  return worksheet.applyRangeFilterAsync("Date", {
    min: new Date(Date.UTC(2010, 3, 1)),
    max: new Date(Date.UTC(2010, 12, 31))
  });
})
// Clearing a Filter
.then(function () {
  return worksheet.clearFilterAsync("Date");
})
// Relative Date
.then(function () {
  return worksheet.applyRelativeDateFilterAsync("Date", {
    anchorDate: new Date(Date.UTC(2011, 5, 1)),
    periodType: tableau.PeriodType.YEAR,
    rangeType: tableau.DateRangeType.LASTN,
    rangeN: 1
  });
})
// Quantitative Filters
// SUM(Sales) > 2000 and SUM(Sales) < 4000
.then(function () {
  return worksheet.applyRangeFilterAsync("SUM(Sales)", {
    min: 2000,
    max: 4000
  });
})
// SUM(Sales) > 1000
.then(function () {
  return worksheet.applyRangeFilterAsync("SUM(Sales)", {
    min: 1000
  });
})
// SUM(Sales) < 1000, excluding null values
.then(function () {
  return worksheet.applyRangeFilterAsync("SUM(Sales)", {
    max: 1000,
    nullOption: tableauSoftware.NullOption.NON_NULL_VALUES
  });
})
// Hierarchical Filters - selecting all on a level
.then(function () {
  return worksheet.applyHierarchicalFilterAsync("[Product].[Product Categories]", {
    levels: [0, 1]
  }, tableau.FilterUpdateType.ADD);
}, function (err) { /* ignore errors */ })
// Hierarchical Filters - adding one item
.then(function () {
  return worksheet.applyHierarchicalFilterAsync(
    "[Product].[Product Categories].[Product Name]",
    "Accessories.Bike Racks.Hitch Rack - 4-Bike",
    tableau.FilterUpdateType.REPLACE);
}, function (err) { /* ignore errors */ })
// Hierarchical Filters - adding multiple items
.then(function () {
  return worksheet.applyHierarchicalFilterAsync(
  "[Product].[Product Categories].[


    https://help.tableau.com/current/api/rest_api/en-us/REST/rest_api_ref_workbooks_and_views.htm#list_custom_views:~:text=REST%20API.-,filter%2Dexpression,-(Optional)%20An%20expression

    // get tableau dashboards filters applied and apply them when i want in js
    // get tableau dashboards filters applied and apply them when i want in js
    var activeFilters = dashboard.getFiltersAsync();
    activeFilters.then(function(filters) {
      console.log(JSON.stringify(filters));
    }).catch(function (error) {
        // Handle error here.
        console.log("Error getting filter information: " + error.toString());
    });

    // Apply the filters to the dashboard
    var filterOptions = {
      "Product Type": "Coffee"
    };
    dashboard.setActiveWorksheet("Sheet 4");
    dashboard.applyDashboardFiltersAsync(filterOptions).then(function() {
      console.log("Filter applied");
    }).catch(function (error) { console.log("Error applying filter: " + error.toString()); } );
});

function trimString(url) {
    // Find the index of the last occurrence of '/'
    const lastSlashIndex = url.lastIndexOf('/');
    
    // Find the index of '?' if it exists
    const questionMarkIndex = url.indexOf('?');
    
    // If '?' exists and occurs after the last '/', extract the substring between '/' and '?'
    if (questionMarkIndex !== -1 && questionMarkIndex > lastSlashIndex) {
      return url.substring(lastSlashIndex + 1, questionMarkIndex);
    }
    
    // If '?' does not exist or occurs before the last '/', return the substring after the last '/'
    return url.substring(lastSlashIndex + 1);
  }