// Forum Post UI - Dark Neon theme
// Converted from Jetpack Compose to ArkTS

// --- App Token Classes ---

class ColorTokens {
  primary: string = '#00E5FF';
  secondary: string = '#FF00AA';
  tertiary: string = '#76FF03';
  background: string = '#101024';
  surface: string = '#1C1C3A';
  surfaceVariant: string = '#282850';
  outline: string = '#44446A';
  success: string = '#00C853';
  warning: string = '#FFD600';
  error: string = '#FF1744';
  onPrimary: string = '#000000';
  onSecondary: string = '#000000';
  onTertiary: string = '#000000';
  onBackground: string = '#E0E0FF';
  onSurface: string = '#E0E0FF';
}

class TypographyTokens {
  displaySize: number = 28;
  displayWeight: FontWeight = FontWeight.Bold;
  headlineSize: number = 22;
  headlineWeight: FontWeight = FontWeight.Medium;
  titleSize: number = 18;
  titleWeight: FontWeight = FontWeight.Medium;
  bodySize: number = 16;
  bodyWeight: FontWeight = FontWeight.Normal;
  labelSize: number = 14;
  labelWeight: FontWeight = FontWeight.Medium;
}

class ShapeTokens {
  small: number = 4;
  medium: number = 8;
  large: number = 16;
}

class SpacingTokens {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class AppTokens {
  static readonly Colors: ColorTokens = new ColorTokens();
  static readonly Typography: TypographyTokens = new TypographyTokens();
  static readonly Shapes: ShapeTokens = new ShapeTokens();
  static readonly Spacing: SpacingTokens = new SpacingTokens();
}

// --- Data Models ---

interface Author {
  name: string;
  avatarColor: string;
}

interface Reply {
  id: number;
  author: Author;
  timestamp: string;
  text: string;
  votes: number;
}

interface Post {
  author: Author;
  timestamp: string;
  title: string;
  body: string;
  votes: number;
  commentCount: number;
}

// --- UpVote Arrow (Diamond Shape) ---

@Component
struct UpVoteArrow {
  color: string = '#44446A';
  isDown: boolean = false;

  build() {
    Canvas(this.drawDiamond.bind(this))
      .width(24)
      .height(24)
  }

  drawDiamond(ctx: CanvasRenderingContext2D) {
    ctx.clearRect(0, 0, 24, 24);
    ctx.fillStyle = this.color;
    ctx.beginPath();
    if (this.isDown) {
      ctx.moveTo(12, 24);
      ctx.lineTo(24, 12);
      ctx.lineTo(12, 0);
      ctx.lineTo(0, 12);
    } else {
      ctx.moveTo(12, 0);
      ctx.lineTo(24, 12);
      ctx.lineTo(12, 24);
      ctx.lineTo(0, 12);
    }
    ctx.closePath();
    ctx.fill();
  }
}

// --- Author Info ---

@Component
struct AuthorInfoComp {
  author: Author = { name: '', avatarColor: '#FFFFFF' };
  timestamp: string = '';

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 24, height: 24 })
          .fill(this.author.avatarColor)
        Circle({ width: 16, height: 16 })
          .fill('rgba(0, 0, 0, 0.2)')
      }
      .width(24)
      .height(24)

      Text(this.author.name)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)
        .margin({ left: AppTokens.Spacing.sm })

      Text(this.timestamp)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(AppTokens.Typography.labelWeight)
        .fontColor(AppTokens.Colors.outline)
        .margin({ left: AppTokens.Spacing.sm })
    }
  }
}

// --- Info Chip ---

@Component
struct InfoChip {
  text: string = '';

  build() {
    Text(this.text)
      .fontSize(AppTokens.Typography.labelSize)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppTokens.Colors.outline)
  }
}

// --- Post Card ---

@Component
struct PostCardComp {
  post: Post = {
    author: { name: '', avatarColor: '#FFFFFF' },
    timestamp: '',
    title: '',
    body: '',
    votes: 0,
    commentCount: 0
  };
  @Link voteState: number;
  onVote: (v: number) => void = () => {};

  build() {
    Row() {
      Column() {
        Button() {
          UpVoteArrow({
            color: this.voteState === 1 ? AppTokens.Colors.secondary : AppTokens.Colors.outline
          })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(40)
        .height(40)
        .borderRadius(20)
        .onClick(() => {
          this.onVote(this.voteState === 1 ? 0 : 1);
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

        Button() {
          UpVoteArrow({
            color: this.voteState === -1 ? AppTokens.Colors.primary : AppTokens.Colors.outline,
            isDown: true
          })
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(40)
        .height(40)
        .borderRadius(20)
        .onClick(() => {
          this.onVote(this.voteState === -1 ? 0 : -1);
        })
      }
      .width(56)
      .alignItems(HorizontalAlign.Center)

      Column() {
        AuthorInfoComp({ author: this.post.author, timestamp: this.post.timestamp })

        Text(this.post.title)
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.sm })

        Text(this.post.body)
          .fontSize(AppTokens.Typography.bodySize)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.8)
          .lineHeight(24)
          .margin({ top: AppTokens.Spacing.sm })

        Row() {
          InfoChip({ text: this.post.commentCount + ' Comments' })
          InfoChip({ text: 'Share' })
            .margin({ left: AppTokens.Spacing.xl })
        }
        .margin({ top: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// --- Reply Card ---

@Component
struct ReplyCardComp {
  reply: Reply = {
    id: 0,
    author: { name: '', avatarColor: '#FFFFFF' },
    timestamp: '',
    text: '',
    votes: 0
  };

  build() {
    Row() {
      Rect({ width: 2, height: '100%' })
        .fill(this.reply.author.avatarColor)
        .opacity(0.5)
        .borderRadius(2)
        .margin({ right: AppTokens.Spacing.md })

      Column() {
        AuthorInfoComp({ author: this.reply.author, timestamp: this.reply.timestamp })

        Text(this.reply.text)
          .fontSize(AppTokens.Typography.bodySize)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.9)
          .lineHeight(24)
          .margin({ top: AppTokens.Spacing.xs })

        Row() {
          InfoChip({ text: this.reply.votes + ' votes' })
          InfoChip({ text: 'Reply' })
            .margin({ left: AppTokens.Spacing.md })
        }
        .margin({ top: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
  }
}

// --- Back Arrow Icon ---

@Component
struct BackArrowIcon {
  build() {
    Canvas(this.drawArrow.bind(this))
      .width(20)
      .height(20)
  }

  drawArrow(ctx: CanvasRenderingContext2D) {
    ctx.clearRect(0, 0, 20, 20);
    ctx.strokeStyle = AppTokens.Colors.primary;
    ctx.lineWidth = 2;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    ctx.beginPath();
    ctx.moveTo(20, 10);
    ctx.lineTo(4, 10);
    ctx.moveTo(4, 10);
    ctx.lineTo(10, 4);
    ctx.moveTo(4, 10);
    ctx.lineTo(10, 16);
    ctx.stroke();
  }
}

// --- Root Screen ---

@Entry
@Component
struct RootScreen {
  @State voteState: number = 1;

  private post: Post = {
    author: { name: 'user/compose_master', avatarColor: AppTokens.Colors.tertiary },
    timestamp: '8 hours ago',
    title: 'The power of Jetpack Compose for single-file UIs',
    body: 'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    votes: 1337,
    commentCount: 42
  };

  private replies: Reply[] = [
    { id: 1, author: { name: 'dev/android_fan', avatarColor: AppTokens.Colors.secondary }, timestamp: '7h ago', text: 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', votes: 25 },
    { id: 2, author: { name: 'ux/designer_jane', avatarColor: AppTokens.Colors.primary }, timestamp: '5h ago', text: 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', votes: 18 },
    { id: 3, author: { name: 'newbie/coder', avatarColor: AppTokens.Colors.warning }, timestamp: '2h ago', text: 'I found it a bit overwhelming at first. Any tips for organizing the file?', votes: 3 }
  ];

  aboutToAppear() {
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Button() {
          BackArrowIcon()
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .borderRadius(24)
        .margin({ left: AppTokens.Spacing.sm })

        Text('r/jetpackcompose')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank()
          .width(48)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)

      // Content
      List() {
        ListItem() {
          PostCardComp({
            post: this.post,
            voteState: $voteState,
            onVote: (v: number) => { this.voteState = v; }
          })
        }

        ListItem() {
          Text('TOP COMMENTS')
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor(AppTokens.Colors.outline)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        }

        ForEach(this.replies, (reply: Reply) => {
          ListItem() {
            ReplyCardComp({ reply: reply })
          }
        }, (reply: Reply) => reply.id.toString())
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .divider(null)

      // Bottom Bar
      Row() {
        Row() {
          Text('Add a comment...')
            .fontSize(AppTokens.Typography.bodySize)
            .fontColor(AppTokens.Colors.outline)
        }
        .layoutWeight(1)
        .height(48)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.large)
        .alignItems(VerticalAlign.Center)

        Button('POST')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(FontWeight.Bold)
          .height(48)
          .borderRadius(AppTokens.Shapes.large)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .margin({ left: AppTokens.Spacing.md })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
