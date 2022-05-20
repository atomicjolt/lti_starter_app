import React from 'react';
import PropTypes from 'prop-types';
import Input from '../common/input';

export default function Form(props) {
  const {
    onChange,
    save,
    closeModal,
    iss,
    clientId,
    jwksUrl,
    tokenUrl,
    oidcUrl,
  } = props;

  return (
    <form>
      <div className="o-grid o-grid__modal-top">
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="iss"
            inputProps={{
              id: 'iss_input',
              name: 'iss',
              type: 'text',
              value: iss,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="client id"
            inputProps={{
              id: 'client_id_input',
              name: 'clientId',
              type: 'text',
              value: clientId,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="jwks url"
            inputProps={{
              id: 'jwks_url_input',
              name: 'jwksUrl',
              type: 'text',
              value: jwksUrl,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="token url"
            inputProps={{
              id: 'token_url_input',
              name: 'tokenUrl',
              type: 'text',
              value: tokenUrl,
              onChange
            }}
          />
        </div>
        <div className="o-grid__item u-half">
          <Input
            className="c-input"
            labelText="oidc url"
            inputProps={{
              id: 'oidc_url_input',
              name: 'oidcUrl',
              type: 'text',
              value: oidcUrl,
              onChange
            }}
          />
        </div>
      </div>
      <button
        type="button"
        onClick={() => save()}
        className="c-btn c-btn--yellow"
      >
        Save
      </button>

      <button
        type="button"
        className="c-btn c-btn--gray--large u-m-right"
        onClick={() => closeModal()}
      >
        Cancel
      </button>
    </form>
  );
}

Form.propTypes = {
  onChange: PropTypes.func.isRequired,
  closeModal: PropTypes.func.isRequired,
  save: PropTypes.func.isRequired,
  iss: PropTypes.string,
  clientId: PropTypes.string,
  jwksUrl: PropTypes.string,
  tokenUrl: PropTypes.string,
  oidcUrl: PropTypes.string,
};
