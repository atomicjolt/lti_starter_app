import React from 'react';
import PropTypes from 'prop-types';
import CanvasAuthentication from 'atomic-canvas/libs/components/canvas_authentication';

export class CanvasAuth extends React.Component {

  static propTypes = {
    settings: PropTypes.shape({
      canvas_auth_required: PropTypes.bool.isRequired,
      has_global_auth: PropTypes.bool.isRequired,
    }).isRequired,
    canvasReAuthorizationRequired: PropTypes.bool,
    autoSubmit: PropTypes.bool,
    hideButton: PropTypes.bool,
  };

  render() {
    const authRequired = this.props.settings.canvas_auth_required
      || this.props.canvasReAuthorizationRequired;
    if (!authRequired) {
      return '';
    }

    // Have to render a larger view area so we don't resize too small to see the Canvas auth page
    const authStyle = {
      height: 600
    };

    if (this.props.canvasReAuthorizationRequired && this.props.settings.has_global_auth) {
      return (
        <div style={authStyle} className="c-main__contain c-text--center c-main__center">
          <h1 className="c-title--large">Canvas API Error</h1>
          <p className="c-text">
            The token used to access the Canvas API is invalid. Please contact Atomic Jolt support
            to resolve the issue.
          </p>
        </div>
      );
    }

    const buttonText = this.props.canvasReAuthorizationRequired ? 'Reauthorize' : 'Authorize';

    return (
      <div style={authStyle} className="c-main__contain c-text--center c-main__center">
        <h1 className="c-title--large">Authorize with Canvas</h1>
        <p className="c-text">Please click the button below to authorize the application to work with Canvas.</p>
        <CanvasAuthentication
          buttonText={buttonText}
          buttonClassName="c-btn c-btn--blue"
          autoSubmit={this.props.autoSubmit}
          hideButton={this.props.hideButton}
        />
      </div>
    );
  }
}

export function displayCanvasAuth(
  settings,
  canvasReAuthorizationRequired,
  autoSubmit = false,
  hideButton = false
) {
  const authRequired = settings.canvas_auth_required
      || canvasReAuthorizationRequired;

  if (authRequired) {
    return (
      <CanvasAuth
        autoSubmit={autoSubmit}
        hideButton={hideButton}
        settings={settings}
        canvasReAuthorizationRequired={canvasReAuthorizationRequired}
      />
    );
  }

  return null;
}
