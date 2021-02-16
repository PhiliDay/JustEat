# JustEat

1.  How long did you spend on the coding test? What would you add to your solution if you had more time? If you didn't spend much time on the coding test then use this as an opportunity to explain what you would add.

I have spent 6 hours on this task.  

If I had more time I would implement a loading state.  I would also seperate the UI into a UITableViewCell to make the implementation clearer and write more tests for the NetworkManager.

A feature that I think would make the overall experience nicer is to have perhaps the list to update everytime you typed a new letter in the postcode.  

2.  What was the most useful feature that was added to the latest version of your chosen language? Please include a snippet of code that shows how you've used it.

I thought a useful feature was the Result in Swift:
`
(Result<[Restaurant], Error>)
`
As used here, with the result in the completion handler it is nicer and clearer: 
`
func fetchRestaurants(postcode: String, completion: @escaping (Result<[Restaurant], Error>) -> Void) {
}
`

This then returns an enum with an associated value which is useful to 
`
    switch result {
    case.success(let results):
        DispatchQueue.main.async {
            self.searchResults = results
            self.tableView.reloadData()
        }
    case .failure(let error):
`

I think it is good because rather than just giving an error if something is wrong, it tell us exactly what is wrong.


3.  How would you track down a performance issue in production? Have you ever had to do this?

I havent had to do this before. A tool such as 'Instruments' could be used to help understand the performance.  You are able to see data from an app and examine and track down the issues within its performance.  You can also write some tests to measure the responsiveness of the UI and measure how fast it takes for the app to start.

4.  How would you improve the Just Eat APIs that you just used?

In the current API there is quite a few repeating fields.  This makes it confusing to understand what to relates to what.  For example, there are quite a few fields for 'rating' e.g. 'rating stars' and 'star rating'.  I also think that some fields could be grouped together more neatly to make the main bulk of information smaller and easier to read.  For example, this information: 

"IsOpenNowForCollection": true,
"IsOpenNowForDelivery": true,
"IsOpenNowForPreorder": false,
"IsOpenNow": true,
`
could look something like 
"RestaurantOpenNow": {
    "CanCollect": true,
    "CanDeliver": true,
    "CanPreorder": false,
    "IsOpen": true
}
