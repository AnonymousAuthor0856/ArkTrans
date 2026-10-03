// entry/src/main/ets/components/AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#7C3AED',
    secondary: '#22D3EE',
    tertiary: '#F97316',
    background: '#050714',
    surface: '#0F172A',
    surfaceVariant: '#1F2937',
    outline: '#334155',
    onPrimary: '#050714',
    onSecondary: '#011014',
    onTertiary: '#110200',
    onBackground: '#F8FAFC',
    onSurface: '#E2E8F0'
  }

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Semibold },
    headline: { size: 22, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 44
  }

  static readonly Shapes = {
    small: 12,
    medium: 16,
    large: 20
  }
}

// entry/src/main/ets/models/ChatThread.ets
export interface ChatThread {
  id: string;
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;
}

// entry/src/main/ets/components/CustomTopBar.ets
import { AppTokens } from './AppTokens';

@Component
export struct CustomTopBar {
  build() {
    Row() {
      Button('Hub')
        .font({ ...AppTokens.Typography.label })
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
      
      Blank()
      
      Column() {
        Text('HoloChat Dock')
          .font({ ...AppTokens.Typography.title })
          .fontColor(AppTokens.Colors.onSurface)
        
        Text('Dark neon bridge')
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
      
      Blank()
      
      Button('Status')
        .font({ ...AppTokens.Typography.label })
        .fontColor(AppTokens.Colors.secondary)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surface)
    .width('100%')
  }
}

// entry/src/main/ets/components/AssistChip.ets
import { AppTokens } from './AppTokens';

@Component
export struct AssistChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  action: () => void = () => {};

  build() {
    Button(this.label)
      .font({ ...AppTokens.Typography.label })
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .borderWidth(this.isSelected ? 0 : 1)
      .borderColor(AppTokens.Colors.outline)
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => {
        this.action();
      })
  }
}

// entry/src/main/ets/components/SummaryBlock.ets
import { AppTokens } from './AppTokens';

@Component
export struct SummaryBlock {
  @Prop title: string;
  @Prop value: string;
  @Prop accent: string;

  build() {
    Column() {
      Circle()
        .fill(this.accent)
        .width(12)
        .height(12)
      
      Text(this.title.toUpperCase())
        .font({ ...AppTokens.Typography.label })
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ top: AppTokens.Spacing.xs })
      
      Text(this.value)
        .font({ ...AppTokens.Typography.display })
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .layoutWeight(1)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
  }
}

// entry/src/main/ets/components/StatusSummary.ets
import { AppTokens } from './AppTokens';
import { SummaryBlock } from './SummaryBlock';

@Component
export struct StatusSummary {
  build() {
    Row() {
      SummaryBlock({ title: 'Live docks', value: '12', accent: AppTokens.Colors.secondary })
      SummaryBlock({ title: 'Escalations', value: '3', accent: AppTokens.Colors.tertiary })
      SummaryBlock({ title: 'Queued', value: '5', accent: AppTokens.Colors.primary })
    }
    .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    .spacing(AppTokens.Spacing.sm)
  }
}

// entry/src/main/ets/components/ChatThreadCard.ets
import { AppTokens } from './AppTokens';
import { ChatThread } from '../models/ChatThread';

@Component
export struct ChatThreadCard {
  @Prop thread: ChatThread;

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.thread.name)
            .font({ ...AppTokens.Typography.headline })
            .fontColor(AppTokens.Colors.onSurface)
          
          Text(this.thread.status)
            .font({ ...AppTokens.Typography.label })
            .fontColor(this.thread.isPriority ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)
            .opacity(this.thread.isPriority ? 1 : 0.7)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
        
        Blank()
        
        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }
      
      Text(this.thread.snippet)
        .font({ ...AppTokens.Typography.body })
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.9)
        .margin({ top: AppTokens.Spacing.sm })
      
      Row() {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
        
        Button('Open')
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.secondary)
          .backgroundColor(Color.Transparent)
          .borderWidth(0)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
  }
}

// entry/src/main/ets/components/ActionFooter.ets
import { AppTokens } from './AppTokens';

@Component
export struct ActionFooter {
  build() {
    Column() {
      Text('Dock filters')
        .font({ ...AppTokens.Typography.title })
        .fontColor(AppTokens.Colors.onSurface)
      
      Row() {
        Button('Calm')
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        
        Button('Fire')
          .font({ ...AppTokens.Typography.label })
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .margin({ left: AppTokens.Spacing.sm })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
  }
}

// entry/src/main/ets/components/BottomInputBar.ets
import { AppTokens } from './AppTokens';

@Component
export struct BottomInputBar {
  @Link text: string;

  build() {
    Row() {
      TextInput({ placeholder: 'Message dock...' })
        .font({ ...AppTokens.Typography.body })
        .fontColor(AppTokens.Colors.onSurface)
        .placeholderColor(AppTokens.Colors.onSurface)
        .placeholderFont({ ...AppTokens.Typography.label })
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .height(48)
        .layoutWeight(1)
        .onChange((value: string) => {
          this.text = value;
        })
      
      Button('Send')
        .font({ ...AppTokens.Typography.label })
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .height(48)
        .padding({ left: 20, right: 20 })
        .margin({ left: AppTokens.Spacing.sm })
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 6, color: '#33000000', offsetY: -2 })
  }
}

// entry/src/main/ets/pages/HoloChatDockScreen.ets
import { AppTokens } from '../components/AppTokens';
import { CustomTopBar } from '../components/CustomTopBar';
import { AssistChip } from '../components/AssistChip';
import { StatusSummary } from '../components/StatusSummary';
import { ChatThreadCard } from '../components/ChatThreadCard';
import { ActionFooter } from '../components/ActionFooter';
import { BottomInputBar } from '../components/BottomInputBar';
import { ChatThread } from '../models/ChatThread';

@Entry
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live';
  @State draftMessage: string = '';
  
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];
  private threads: ChatThread[] = [
    { id: '1', name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
    { id: '2', name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
    { id: '3', name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        CustomTopBar()
        
        Scroll() {
          Column() {
            // Filters
            Scroll() {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({ 
                    label: filter, 
                    isSelected: this.activeFilter === filter 
                  })
                    .onClick(() => {
                      this.activeFilter = filter;
                    })
                    .margin({ right: AppTokens.Spacing.sm })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .width('100%')
            
            StatusSummary()
            
            // Threads List
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
            })
            
            ActionFooter()
            
            // Spacer for bottom bar + FAB area
            Blank().height(100)
          }
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
      }
      .backgroundColor(AppTokens.Colors.background)
      
      // FAB (Floating Action Button) overlay
      Column() {
        Blank()
        Row() {
          Blank()
          Button('New')
            .font({ ...AppTokens.Typography.label })
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
            .shadow({ radius: 4, color: '#33000000' })
            .margin({ right: AppTokens.Spacing.lg, bottom: 80 })
        }
      }
      .width('100%')
      .height('100%')
      
      // Bottom Bar
      BottomInputBar({ text: $draftMessage })
    }
    .backgroundColor(AppTokens.Colors.background)
  }
}