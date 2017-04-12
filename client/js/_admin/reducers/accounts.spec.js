import accounts from './accounts';
import {
  helperListAccounts,
} from '../../libs/canvas/helper_constants';

describe('accounts reducer', () => {
  describe('initial state', () => {
    it('returns empty state', () => {
      const initialState = {};
      const state = accounts(initialState, {});
      expect(state).toEqual({});
    });
  });

  describe('update loading', () => {
    it('updates loading', () => {
      const state = undefined;
      const loading = true;
      const result = accounts(state, helperListAccounts);
      expect(result.loading).toBe(loading);
    });
  });
});
