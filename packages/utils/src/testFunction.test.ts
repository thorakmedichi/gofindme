import { testFunction } from './testFunction';

describe('Test Function', () => {
  it('has the correct text displayed when run', () => {
    expect(testFunction()).toEqual('Some testing content')
  });
});
