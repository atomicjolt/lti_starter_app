import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import {
  createExternalToolAccounts,
  deleteExternalToolAccounts,
} from '../../../../libs/canvas/constants/external_tools';

export default function AccountInstall(props) {
  function install(applicationInstance, installedTool) {
    if (installedTool) {
      props.canvasRequest(
        deleteExternalToolAccounts,
        { account_id: props.account.id, external_tool_id: installedTool.id },
        null,
        props.account,
      );
    } else {
      props.canvasRequest(
        createExternalToolAccounts,
        { account_id: props.account.id },
        {
          name          : applicationInstance.name,
          consumer_key  : applicationInstance.lti_key,
          shared_secret : applicationInstance.lti_secret,
          privacy_level : 'public',
          config_type   : 'by_xml',
          config_xml    : applicationInstance.lti_config_xml
        },
        props.account,
      );
    }
  }

  const externalTools = props.account && props.account.external_tools;
  const installedTool = _.find(externalTools, tool => (
    tool.consumer_key === props.applicationInstance.lti_key
  ));
  const accountName = props.account ? props.account.name : 'Root';
  const buttonText = installedTool ? 'Uninstall From Account' : 'Install Into Account';

  return (
    <div className="c-info">
      <div className="c-title">
        <h1>{props.accountInstalls}</h1>
        <h3>{accountName}</h3>
      </div>
      <button
        className="c-btn c-btn--yellow"
        onClick={() => install(props.applicationInstance, installedTool)}
      >{buttonText}</button>
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
