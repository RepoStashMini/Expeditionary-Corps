// THIS IS A NOVA SECTOR UI FILE
import {Section, Stack } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../../backend';

type HeaderInfo = {
  isTargetSelf: BooleanLike;
};

export const InfoSection = () => {
  const { data } = useBackend<HeaderInfo>();
  const {
    isTargetSelf,
  } = data;
  return (
    <Section fill>
      <Stack vertical fill>
        <Stack.Item grow>
          <Stack>
            <Stack.Item grow>You...</Stack.Item>
            {!isTargetSelf ? <Stack.Item grow>They...</Stack.Item> : null}
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
