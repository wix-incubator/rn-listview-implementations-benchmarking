import {NativeModules} from 'react-native';
import _ from 'lodash';

class BridgeNoise {
  constructor() {
    this._stats = {};
    this._chunkSize = 0;
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
  }

  start() {
    if(this._timer !== undefined) {
      console.warn("BridgeNoise is already active");
      return;
    }

    this._timer = setInterval(() => {
      NativeModules.BridgeNoise.receiveAndSendData(
        this._randomStringOfLenth(this._chunkSize),
        new Date(Date.now() + (10 * 1000)).getTime(),
        this._chunkSize,
        (str, timestamp, stats) => {
          this._stats = stats;
        }
      )
    }, 1);
  }

  stop() {
    if(this._timer === undefined) {
      console.warn("BridgeNoise is already inactive");
      return;
    }

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

export default new BridgeNoise();