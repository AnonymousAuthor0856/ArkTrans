// pages/Index.ets — ArkTS (ArkUI) port of the single-file Jetpack Compose UI.

// ---------------------------------------------------------------- tokens

class AppColors {
  static readonly primary: string = '#00E5FF';
  static readonly secondary: string = '#FF00AA';
  static readonly tertiary: string = '#76FF03';
  static readonly background: string = '#101024';
  static readonly surface: string = '#1C1C3A';
  static readonly surfaceVariant: string = '#282850';
  static readonly outline: string = '#44446A';
  static readonly success: string = '#00C853';
  static readonly warning: string = '#FFD600';
  static readonly error: string = '#FF1744';
  static readonly onPrimary: string = '#000000';
  static readonly onSecondary: string = '#000000';
  static readonly onTertiary: string = '#000000';
  static readonly onBackground: string = '#E0E0FF';
  static readonly onSurface: string = '#E0E0FF';
}

class AppTypography {
  static readonly display: number = 28;
  static readonly headline: number = 22;
  static readonly title: number = 18;
  static readonly body: number = 16;
  static readonly bodyLine: number = 24;
  static readonly label: number = 14;
  static readonly labelSpacing: number = 0.5;
}

class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class AppElevation {
  static readonly level1: ShadowOptions = { radius: 2, color: 'rgba(0,0,0,0.10)', offsetX: 0, offsetY: 1 };
  static readonly level2: ShadowOptions = { radius: 4, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: 2 };
  static readonly level3: ShadowOptions = { radius: 8, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 4 };
}

/** '#RRGGBB' -> 'rgba(r, g, b, a)' (Compose's Color.copy(alpha = …)). */
function withAlpha(hex: string, alpha: number): string {
  const r: number = parseInt(hex.substring(1, 3), 16);
  const g: number = parseInt(hex.substring(3, 5), 16);
  const b: number = parseInt(hex.substring(5, 7), 16);
  return `rgba(${r}, ${g}, ${b}, ${alpha})`;
}

// ---------------------------------------------------------------- models

class Author {
  name: string;
  avatarColor: string;

  constructor(name: string, avatarColor: string) {
    this.name = name;
    this.avatarColor = avatarColor;
  }
}

class Reply {
  id: number;
  author: Author;
  timestamp: string;
  text: string;
  votes: number;

  constructor(id: number, author: Author, timestamp: string, text: string, votes: number) {
    this.id = id;
    this.author = author;
    this.timestamp = timestamp;
    this.text = text;
    this.votes = votes;
  }
}

class Post {
  author: Author;
  timestamp: string;
  title: string;
  body: string;
  votes: number;
  commentCount: number;

  constructor(author: Author, timestamp: string, title: string, body: string,
              votes: number, commentCount: number) {
    this.author = author;
    this.timestamp = timestamp;
    this.title = title;
    this.body = body;
    this.votes = votes;
    this.commentCount = commentCount;
  }
}

// ---------------------------------------------------------------- screen

@Entry
@Component
struct RootScreen {
  @State voteState: number = 1;

  private post: Post = new Post(
    new Author('user/compose_master', AppColors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    "Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it's becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?",
    1337,
    42
  );

  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', AppColors.secondary), '7h ago',
      'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, new Author('ux/designer_jane', AppColors.primary), '5h ago',
      'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', 18),
    new Reply(3, new Author('newbie/coder', AppColors.warning), '2h ago',
      'I found it a bit overwhelming at first. Any tips for organizing the file?', 3)
  ];

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.PostCard()

          Text('TOP COMMENTS')
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(AppTypography.labelSpacing)
            .fontColor(AppColors.outline)
            .width('100%')
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })

          ForEach(this.replies, (reply: Reply) => {
            this.ReplyCard(reply)
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  // -------------------------------------------------------------- top bar

  @Builder
  TopBar() {
    Stack() {
      Row() {
        Path()
          .width(24)
          .height(24)
          .commands('M15 4 L7 12 L15 20')
          .fillOpacity(0)
          .stroke(AppColors.primary)
          .strokeWidth(2)
          .strokeLineCap(LineCapStyle.Round)
          .strokeLineJoin(LineJoinStyle.Round)
          .onClick(() => {
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(VerticalAlign.Center)

      Text('r/jetpackcompose')
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
  }

  // ------------------------------------------------------------ bottom bar

  @Builder
  BottomBar() {
    Row({ space: AppSpacing.md }) {
      Row() {
        Text('Add a comment...')
          .fontSize(AppTypography.body)
          .fontColor(AppColors.outline)
      }
      .layoutWeight(1)
      .height(48)
      .borderRadius(AppShapes.large)
      .backgroundColor(AppColors.surfaceVariant)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(VerticalAlign.Center)

      Button('POST')
        .type(ButtonType.Normal)
        .height(48)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Bold)
        .padding({ left: AppSpacing.xl, right: AppSpacing.xl })
        .onClick(() => {
        })
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColors.surface)
    .shadow(AppElevation.level3)
  }

  // ------------------------------------------------------------ post card

  @Builder
  PostCard() {
    Row({ space: AppSpacing.md }) {
      Column({ space: AppSpacing.sm }) {
        Stack() {
          this.UpVoteArrow(this.voteState === 1 ? AppColors.secondary : AppColors.outline, 24)
        }
        .width(36)
        .height(36)
        .onClick(() => {
          this.voteState = this.voteState === 1 ? 0 : 1;
        })

        Text((this.post.votes + this.voteState - 1).toString())
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppColors.secondary : AppColors.onSurface)

        Stack() {
          this.UpVoteArrow(this.voteState === -1 ? AppColors.primary : AppColors.outline, 24)
        }
        .width(36)
        .height(36)
        .onClick(() => {
          this.voteState = this.voteState === -1 ? 0 : -1;
        })
      }
      .alignItems(HorizontalAlign.Center)

      Column({ space: AppSpacing.sm }) {
        this.AuthorInfo(this.post.author, this.post.timestamp)

        Text(this.post.title)
          .fontSize(AppTypography.headline)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Text(this.post.body)
          .fontSize(AppTypography.body)
          .lineHeight(AppTypography.bodyLine)
          .fontColor(withAlpha(AppColors.onSurface, 0.8))
          .width('100%')

        Row({ space: AppSpacing.xl }) {
          this.InfoChip(`${this.post.commentCount} Comments`)
          this.InfoChip('Share')
        }
        .margin({ top: AppSpacing.sm })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .backgroundColor(AppColors.surface)
    .padding(AppSpacing.lg)
  }

  // ----------------------------------------------------------- reply card

  @Builder
  ReplyCard(reply: Reply) {
    Column({ space: AppSpacing.xs }) {
      this.AuthorInfo(reply.author, reply.timestamp)

      Text(reply.text)
        .fontSize(AppTypography.body)
        .lineHeight(AppTypography.bodyLine)
        .fontColor(withAlpha(AppColors.onSurface, 0.9))
        .width('100%')

      Row({ space: AppSpacing.md }) {
        this.InfoChip(`${reply.votes} votes`)
        this.InfoChip('Reply')
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppSpacing.xs })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding({
      left: AppSpacing.md,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .border({ width: { left: 2 }, color: withAlpha(reply.author.avatarColor, 0.5) })
    .borderRadius({ topLeft: 2, bottomLeft: 2 })
    .margin({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
  }

  // ------------------------------------------------------------ fragments

  @Builder
  AuthorInfo(author: Author, timestamp: string) {
    Row({ space: AppSpacing.sm }) {
      Stack() {
        Circle().width(24).height(24).fill(author.avatarColor)
        Circle().width(16).height(16).fill('rgba(0, 0, 0, 0.2)')
      }
      .width(24)
      .height(24)

      Text(author.name)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Bold)
        .fontColor(author.avatarColor)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(timestamp)
        .fontSize(AppTypography.label)
        .fontColor(AppColors.outline)
        .layoutWeight(1)
        .maxLines(2)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoChip(text: string) {
    Text(text)
      .fontSize(AppTypography.label)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.outline)
  }

  @Builder
  UpVoteArrow(color: string, size: number) {
    Path()
      .width(size)
      .height(size)
      .commands('M12 0 L24 12 L12 24 L0 12 Z')
      .fill(color)
  }
}