import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer, { act } from 'react-test-renderer';
import ApplicationRow from './application_row';

describe('applications application row', () => {
  let result;
  let instance;

  const application = {
    id: 314159,
    name: 'SPECNAME',
    application_instances_count: 1234
  };
  const saveApplication = () => {};

  // https://medium.com/@amanverma.dev/mocking-create-portal-to-utilize-react-test-renderer-in-writing-snapshot-uts-c49773c88acd
  beforeAll(() => {
    ReactDOM.createPortal = jest.fn((element) => element);
  });

  afterEach(() => {
    ReactDOM.createPortal.mockClear();
  });

  beforeEach(() => {
    result = TestRenderer.create(
      <ApplicationRow
        application={application}
        saveApplication={saveApplication}
      />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('button is clicked', () => {
    const modals = instance.findAllByProps({ className: 'c-modal__title' });
    expect(modals.length).toEqual(0);

    act(() => {
      instance.findByType('button').props.onClick();
    });

    expect(instance.findByProps({ className: 'c-modal__title' })).toBeDefined();
  });
});
