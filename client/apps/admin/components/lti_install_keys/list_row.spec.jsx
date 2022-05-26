import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer, { act } from 'react-test-renderer';
import ListRow from './list_row';

describe('application instances list row', () => {
  let props;
  let result;
  let instance;
  let deleted;

  beforeAll(() => {
    ReactDOM.createPortal = jest.fn((element) => element);
  });

  afterEach(() => {
    ReactDOM.createPortal.mockClear();
  });

  beforeEach(() => {
    deleted = false;
    props = {
      delete: () => { deleted = true; },
      save: () => {},
      ltiInstallKey: {
        id: 2,
        application_id: 23,
        clientId: 'lti-key',
        iss: 'iss',
        jwksUrl: 'jwksUrl',
        tokenUrl: 'tokenUrl',
        oidcUrl: 'oidcUrl',
        created_at: 'created_at',
      },
    };
    result = TestRenderer.create(<ListRow {...props} />);
    instance = result.root;
  });

  // the following tests will break if the order of the buttons is changed
  // to remedy this a class would need to be added to each button

  it('handles the opening of the modal', () => {
    expect(result).toMatchSnapshot();
    const buttons = instance.findAllByType('button');
    act(() => {
      buttons[0].props.onClick();
    });

    expect(result).toMatchSnapshot();
    const h2 = instance.findAllByType('h2');
    expect(h2.length).toBe(1);
  });

  it('handles deleting', () => {
    let buttons = instance.findAllByType('button');
    act(() => {
      buttons[1].props.onClick();
    });

    buttons = instance.findAllByType('button');
    const button = buttons.find((b) => b.children[0] === 'Cancel');
    expect(button).toBeTruthy();
  });
});
