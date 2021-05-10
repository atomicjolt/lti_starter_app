import React from 'react';

export default class Loader extends React.PureComponent {
  render() {
    return (
      <div>
        <div className="loading">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 91.87 114.09" role="img" aria-label="loading">
            <g data-name="Layer 2">
              <polygon className="cls-1" points="40.45 111.32 89.11 99.26 71.35 19.9 21.1 89.71 40.45 111.32" />
              <polyline className="cls-2" points="50.67 2.77 2.77 69.96 25.47 94.65 66.36 84.13 50.67 2.77 71.35 19.9" />
            </g>
          </svg>
        </div>
      </div>
    );
  }
}
