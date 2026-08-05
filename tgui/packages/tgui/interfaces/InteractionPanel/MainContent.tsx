// THIS IS A NOVA SECTOR UI FILE
import { useState } from 'react';
import {
  Button,
  Icon,
  Input,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
//import type { BooleanLike } from 'tgui-core/react';
//import { useBackend } from '../../backend';

enum InteractionTab {
  Interactions = 0,
}

//import { InteractionsTab, } from './tabs';
export const MainContent = () => {
  const [searchText, setSearchText] = useState('');
  const [tabIndex, setTabIndex] = useState(InteractionTab.Interactions);
  const [showCategories, setShowCategories] = useState(true);
  const placeholder =
    tabIndex === InteractionTab.Interactions
      ? 'Search for an interaction'
        : 'Searching is unavailable for this tab';
  return (
    <Section fill>
      <Stack vertical fill>
        <Stack.Item>
          <Tabs fluid textAlign="center">
            <Tabs.Tab
              selected={tabIndex === InteractionTab.Interactions}
              onClick={() => setTabIndex(InteractionTab.Interactions)}
            >
              Interactions
            </Tabs.Tab>
          </Tabs>
        </Stack.Item>
        <Stack.Item>
          <Stack align="baseline" fill>
            <Stack.Item>
              <Icon name="search" />
            </Stack.Item>
            <Stack.Item grow>
              <Input
                fluid
                width="200px"
                value={searchText}
                placeholder={placeholder}
                onChange={(value) => setSearchText(value)}
              />
            </Stack.Item>
            {tabIndex === InteractionTab.Interactions && (
              <Stack.Item>
                <Button
                  icon={showCategories ? 'folder' : 'list'}
                  color="green"
                  tooltip={
                    showCategories ? 'Hide Categories' : 'Show Categories'
                  }
                  onClick={() => setShowCategories(!showCategories)}
                />
              </Stack.Item>
            )}
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
