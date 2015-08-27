const Browser = require('zombie');

// We're going to make requests to http://example.com/signup
// Which will be routed to our test server localhost:3000
Browser.localhost('0.0.0.0', 3000);

describe('User visits playlist page', function() {

  const browser = new Browser();

  before(function(done) {
    return browser.visit('/all-playlists', done);
  });

  describe('Check title', function() {
    it('should be "Playlist Forge"', function() {
      browser.assert.text('title', 'Playlist Forge');
    });
  });
});