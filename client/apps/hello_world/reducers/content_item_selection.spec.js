import contentItemSelection from './content_item_selection';

describe('contentItemSelection reducer', () => {
  describe('initial state', () => {
    it('returns empty state', () => {
      const initialState = {};
      const state = contentItemSelection(initialState, {});
      expect(state).toEqual({});
    });
  });
});
