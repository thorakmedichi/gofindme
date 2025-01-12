import { testFunction } from '@gofindme/utils';
import { type V2_MetaFunction } from '@remix-run/node';
import { Button } from '@ui/Button';

export const meta: V2_MetaFunction = () => [
  { title: 'New Remix App' },
  { content: 'Welcome to Remix!', name: 'description' },
];

export default function Index() {
  return (
    <div style={{ fontFamily: 'system-ui, sans-serif', lineHeight: '1.8' }}>
      {testFunction()}
      <br />
      <Button
        label="Testing"
        size="large"
        onClick={() => {
          // eslint-disable-next-line no-console
          console.log('test');
        }}
      />

      <h1>Welcome to Remix</h1>
      <ul>
        <li>
          <a
            target="_blank"
            href="https://remix.run/tutorials/blog"
            rel="noreferrer"
          >
            15m Quickstart Blog Tutorial
          </a>
        </li>
        <li>
          <a
            target="_blank"
            href="https://remix.run/tutorials/jokes"
            rel="noreferrer"
          >
            Deep Dive Jokes App Tutorial
          </a>
        </li>
        <li>
          <a target="_blank" href="https://remix.run/docs" rel="noreferrer">
            Remix Docs
          </a>
        </li>
      </ul>
    </div>
  );
}
