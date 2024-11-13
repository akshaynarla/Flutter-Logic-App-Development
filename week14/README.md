# go_dice

A golang project for rolling 10 pairs of dice at random. This is based on the requirements from Exercise Sheet-5. Refer the app images and video clip added in the folder [imgs](/imgs/)

## Implementation of Server requirements

The golang server reuses the created dice class from week12, although it's contents are copied here. The functionality of the server is provided in the [video in the imgs folder](/imgs/)

### Basic Requirements
- [x] 10 pairs of dice --> implemented as dicePair array in the program.
- [x] POST/dice/{number_of_pair} should roll corresponding pair of dice --> use  with the localhost to roll corresponding dice. Can be verified with `Invoke-RestMethod -Uri http://localhost:8080/dice/5 -Method Post` or by using curl.
- [x] GET/dice/{number_of_pair} should return html document with the corresponding stats and a button for rolling dice (previous post functionality reused here) --> tested with InvokeRest method as well as the button is provided in the html document (verify with any browser) --> `Invoke-RestMethod -Uri http://localhost:8080/dice/5 -Method Get` --> in command prompt or powershell, you get the html equivalent representation.
- [x] GET/statistics/{number_of_pair} --> statistics of the corresponding pair of dice --> same as above --> get data in browser as well as the command line.
- [x] POST/reset/{number_of_pair} --> reset all stats of the corresponding pair --> resets the data only for the corresponding pair of dice being invoked.

# References:

- [HTML Documentation](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference)
- [Golang Server implementation example](https://dev.to/stungnet/making-a-basic-http-server-with-golang-37lk)
- [Official example from Golang docs](https://go.dev/doc/articles/wiki/)
- [HTML template example and routing example](https://gowebexamples.com/templates/)