import {NativeModules} from 'react-native';
import _ from 'lodash';

class SlowJSSimulator {
  constructor() {
    this._interval = 1;
    this._chunkSize = 0;
    this._busyWait = 0;
    this._stats = {};
    this._timer = undefined;
    
    this._stringBlocks = [
         "___jfdshgkljhdasfgkljd hfgkljshd fkljghew85rhgkdsuifhgkdsjfhglkdjfhgkjdgfhkgdf",
         "___dsjfhr938hg fipwe8ugpiwerugyw4598yutpsiiftfkgdjshfgi8esyagfiausdfjhgk",
         "___udgifughs jlfdgh9834ytksdufjhklsdjfghslkdjfgkdufghsldui90384576ytieurhgkludrfhgkj",
         "___dirfuhgip8erybivpot8ey54iyhdroiusghoi845ygie85yuiopse5uygpios8e5uypigos5eugpoe",
         "___SJDFHGKLD854HTKLUJ940we80t9ue;zokgfdj ;o98U:OiHK:JHskfdj"
    ];
  }

  chunksReceived() {
    return _.get(this._stats, 'chunksReceived', 0);
  }

  chunksSent() {
    return _.get(this._stats, 'chunksSent', 0);
  }

  bytesReceived() {
    return _.get(this._stats, 'bytesReceived', 0);
  }

  bytesSent() {
    return _.get(this._stats, 'bytesSent', 0);
  }

  chunkSize() {
    return this._chunkSize;
  }

  setChunkSize(value) {
    this._chunkSize = Math.floor(value);
    this._update();
  }

  busyWait() {
    return this._busyWait;
  }

  setBusyWait(value) {
    this._busyWait = value;
    this._update();
  }

  interval() {
    return this._interval;
  }

  setInterval(value) {
    this._interval = value;
    this._update();
  }

  _update() {
    if(this._timer !== undefined) {
      this._stop();
    }

    if(this._chunkSize > 0 || this._busyWait > 0) {
      this._start();
    }
  }

  _start() {
    this._timer = setInterval(() => {
      if(this._chunkSize > 0) {
        NativeModules.BridgeNoise.receiveAndSendData(
          this._randomStringOfLenth(this._chunkSize),
          new Date(Date.now() + (10 * 1000)).getTime(),
          this._chunkSize,
          (str, timestamp, stats) => {
            this._stats = stats;
          }
        )
      }

      var i = this._busyWait;
      while(i-- > 0);
    }, 1);
  }

  _stop() {
    clearInterval(this._timer);
    this._timer = undefined;
  }

  isActive() {
    return this._timer !== undefined;
  }

  _randomStringOfLenth(length) {
    const parts = [];
    while(length > 0) {
        const i = Math.floor(Math.random() * this._stringBlocks.length);
        var part = this._stringBlocks[i];
        if(part.length > length) {
            part = part.substring(0, length);
        }
        length -= part.length;
        parts.push(part);
    }
    
    return parts.join('');
  }
}

export default new SlowJSSimulator();