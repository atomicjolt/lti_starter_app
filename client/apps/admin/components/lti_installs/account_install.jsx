import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import {
  createExternalToolAccounts,
  deleteExternalToolAccounts,
} from 'atomic-canvas/libs/constants/external_tools';

export default function AccountInstall(props) {
  const {
    accountInstalls,
    applicationInstance,
    account,
    canvasRequest,
  } = props;

  function install(installedTool) {
    if (installedTool) {
      canvasRequest(
        deleteExternalToolAccounts,
        { account_id: account.id, external_tool_id: installedTool.id },
        null,
        account,
      );
    } else {
      canvasRequest(
        createExternalToolAccounts,
        { account_id: account.id },
        {
          name          : applicationInstance.name,
          consumer_key  : applicationInstance.lti_key,
          shared_secret : applicationInstance.lti_secret,
          config_type   : 'by_xml',
          config_xml    : applicationInstance.lti_config_xml
        },
        account,
      );
    }
  }

  const externalTools = account && account.external_tools;
  const installedTool = _.find(externalTools, (tool) => (
    tool.consumer_key === applicationInstance.lti_key
  ));
  const accountName = account ? account.name : 'Root';
  const buttonText = installedTool ? 'Uninstall From Account' : 'Install Into Account';

  return (
    <div className="c-info">
      <div className="c-title">
        <h1>{accountInstalls}</h1>
        <h3>{accountName}</h3>
      </div>
      <button
        className="c-btn c-btn--yellow"
        onClick={() => install(applicationInstance, installedTool)}
        type="button"
      >
        {buttonText}
      </button>
    </div>
  );
}

AccountInstall.propTypes = {
  accountInstalls     : PropTypes.number,
  applicationInstance : PropTypes.shape({}),
  account             : PropTypes.shape({
    name           : PropTypes.string,
    external_tools : PropTypes.shape({}),
  }),
};
