import { postMessage } from 'atomic-fuel/libs/actions/post_message';

function calculateIframeHeight() {
  const container = document.getElementById('main-app');
  if (!container) { return 0; }
  // Fudge factor to account for extra height of iframe that scrollHeight doesn't include
  const fudge = 5;
  return container.scrollHeight + fudge;
}

function sendLtiIframeResize() {
  const height = calculateIframeHeight();
  if (height > 0) {
    const message = { subject: 'lti.frameResize', height };
    postMessage(message, true);
  }
}

export default function initResizeHanlder(domEl) {
  domEl.addEventListener('onresize', () => {
    sendLtiIframeResize();
  });
}

