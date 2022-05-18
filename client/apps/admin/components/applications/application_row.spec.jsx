import React from 'react';
import TestRenderer from 'react-test-renderer';
import ReactTestUtils from 'react-dom/test-utils';
import ApplicationRow from './application_row';

describe('applications application row', () => {
  let result;
  let instance;

  const application = {
    id                          : 314159,
    name                        : 'SPECNAME',
    application_instances_count : 1234
  };
  const saveApplication = () => {};

  beforeEach(() => {
    result = TestRenderer.create(<ApplicationRow
      application={application}
      saveApplication={saveApplication}
    />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('button is clicked', () => {
    expect(result.root.state.modalOpen).toBeFalsy();

    const h1 = ReactTestUtils.findRenderedDOMComponentWithClass(instance, 'c-modal__title');
    expect(h1).
    
    instance.findByType('button').props.onClick();
    expect(result.root.state.modalOpen).toBeTruthy();
  });
});
