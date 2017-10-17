import React from 'react';
import { shallow } from 'enzyme';
import Modal from './modal';

describe('application instance modal', () => {

  let result;
  let props;
  let closed;
  let saved;
  const name = 'the application';

  beforeEach(() => {
    saved = false;
    closed = false;
    props = {
      isOpen: true,
      closeModal: () => { closed = true; },
      sites: {},
      save: () => { saved = true; },
      applicationInstance: {
        id: 2,
        config: 'config string',
        site: {
          id: 3,
        },
      },
      application: {
        id: 1,
        name
      }
    };
    result = shallow(<Modal {...props} />);
  });

  it('match the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the changing of the siteModalOpen state open', () => {
    expect(result.instance().state.siteModalOpen).toBeFalsy();
    result.instance().newSite();
    expect(result.instance().state.siteModalOpen).toBeTruthy();
  });

  it('handles the changing of the siteModalOpen state to close', () => {
    expect(closed).toBeFalsy();
    expect(result.instance().state.siteModalOpen).toBeFalsy();
    result.instance().newSite();
    expect(result.instance().state.siteModalOpen).toBeTruthy();
    result.instance().closeModal();
    expect(closed).toBeTruthy();
    expect(result.instance().state.siteModalOpen).toBeFalsy();
  });

  it('renders isOpen class appropriately', () => {
    expect(result.find('.is-open').length).toEqual(1);
    props.isOpen = false;
    result = shallow(<Modal {...props} />);
    expect(result.find('.is-open').length).toEqual(0);
  });

  it('handles the save function', () => {
    expect(saved).toBeFalsy();
    expect(result.instance().state.siteModalOpen).toBeFalsy();
    result.instance().newSite();
    expect(result.instance().state.siteModalOpen).toBeTruthy();
    result.instance().save();
    expect(saved).toBeTruthy();
  });
});
