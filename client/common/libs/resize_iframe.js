import _ from 'lodash';
import ResizeObserver from 'resize-observer-polyfill';
import { broadcastMessage } from 'atomic-fuel/libs/communications/communicator';

function sendLtiIframeResize(height) {
  if (height > 0) {
    const message = { subject: 'lti.frameResize', height };
    broadcastMessage(message);
  }
}

export default function initResizeHandler(el) {
  const observer = new ResizeObserver((resizeObservers) => {
    const found = _.find(resizeObservers, re => re.target === el);
    if (found) {
      const height = found.contentRect.height;
      sendLtiIframeResize(height);
    }
  });
  observer.observe(el);
}

