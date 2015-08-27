var Browser = require('zombie');

// We're going to make requests to localhost:3000
Browser.localhost('0.0.0.0', 3000);
var browser = new Browser();


// All your tests live inside this block
describe('User visits playlist page', function() {

  before(function(done) {
    browser.visit('/all-playlists', done);
  });

  describe('Check title', function() {
    it('should be "Playlist Forge"', function() {
      browser.assert.text('title', 'Playlist Forge');
    });
  });
});