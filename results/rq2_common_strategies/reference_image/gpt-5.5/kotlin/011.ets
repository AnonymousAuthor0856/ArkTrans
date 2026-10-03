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

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

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

  constructor(author: Author, timestamp: string, title: string, body: string, votes: number, commentCount: number) {
    this.author = author;
    this.timestamp = timestamp;
    this.title = title;
    this.body = body;
    this.votes = votes;
    this.commentCount = commentCount;
  }
}

const MAIN_POST: Post = new Post(
  new Author('user/compose_master', AppColors.tertiary),
  '8 hours ago',
  'The power of Jetpack Compose for single-file UIs',
  'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
  1337,
  42
);

const REPLIES: Reply[] = [
  new Reply(
    1,
    new Author('dev/android_fan', AppColors.secondary),
    '7h ago',
    'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.',
    25
  ),
  new Reply(
    2,
    new Author('ux/designer_jane', AppColors.primary),
    '5h ago',
    'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.',
    18
  ),
  new Reply(
    3,
    new Author('newbie/coder', AppColors.warning),
    '2h ago',
    'I found it a bit overwhelming at first. Any tips for organizing the file?',
    3
  )
];

@Component
struct DiamondIcon {
  color: string = AppColors.outline;
  size: number = 28;

  build() {
    Text('◆')
      .fontSize(this.size)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.color)
      .width(48)
      .height(48)
      .textAlign(TextAlign.Center)
      .lineHeight(48)
  }
}

@Component
struct AppTopBar {
  build() {
    Row() {
      Text('←')
        .fontSize(46)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.primary)
        .width(96)
        .height('100%')
        .textAlign(TextAlign.Center)
        .lineHeight(88)

      Text('r/jetpackcompose')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .maxLines(1)

      Blank()
        .width(96)
        .height('100%')
    }
    .width('100%')
    .height(96)
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct AuthorInfo {
  author: Author = new Author('', AppColors.primary);
  timestamp: string = '';

  build() {
    Row({ space: AppSpacing.sm }) {
      Stack({ alignContent: Alignment.Center }) {
        Blank()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(this.author.avatarColor)

        Blank()
          .width(14)
          .height(14)
          .borderRadius(7)
          .backgroundColor('#33000000')
      }
      .width(24)
      .height(24)

      Text(this.author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.author.avatarColor)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.outline)
        .maxLines(2)
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoChip {
  text: string = '';

  build() {
    Text(this.text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.outline)
      .maxLines(1)
  }
}

@Component
struct PostCard {
  post: Post = MAIN_POST;
  voteState: number = 1;
  onVote: (value: number) => void = (value: number): void => {};

  build() {
    Row({ space: AppSpacing.md }) {
      Column({ space: AppSpacing.sm }) {
        DiamondIcon({
          color: this.voteState === 1 ? AppColors.secondary : AppColors.outline,
          size: 35
        })
          .onClick(() => {
            this.onVote(this.voteState === 1 ? 0 : 1);
          })

        Text(`${this.post.votes + this.voteState - 1}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? AppColors.secondary : AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width(64)

        DiamondIcon({
          color: this.voteState === -1 ? AppColors.primary : AppColors.outline,
          size: 35
        })
          .onClick(() => {
            this.onVote(this.voteState === -1 ? 0 : -1);
          })
      }
      .width(80)
      .alignItems(HorizontalAlign.Center)

      Column({ space: AppSpacing.sm }) {
        AuthorInfo({
          author: this.post.author,
          timestamp: this.post.timestamp
        })

        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .lineHeight(30)

        Text(this.post.body)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .opacity(0.8)
          .lineHeight(24)

        Blank()
          .height(AppSpacing.sm)

        Row({ space: AppSpacing.xl }) {
          InfoChip({ text: `${this.post.commentCount} Comments` })
          InfoChip({ text: 'Share' })
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.lg,
      bottom: AppSpacing.xl
    })
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct ReplyCard {
  reply: Reply = new Reply(0, new Author('', AppColors.primary), '', '', 0);

  build() {
    Row({ space: AppSpacing.md }) {
      Blank()
        .width(2)
        .height('100%')
        .borderRadius(2)
        .backgroundColor(this.reply.author.avatarColor)
        .opacity(0.5)

      Column({ space: AppSpacing.xs }) {
        AuthorInfo({
          author: this.reply.author,
          timestamp: this.reply.timestamp
        })

        Text(this.reply.text)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .opacity(0.9)
          .lineHeight(24)

        Row({ space: AppSpacing.md }) {
          InfoChip({ text: `${this.reply.votes} votes` })
          InfoChip({ text: 'Reply' })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: AppSpacing.xs })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.lg
    })
    .alignItems(VerticalAlign.Stretch)
  }
}

@Component
struct BottomCommentBar {
  build() {
    Row({ space: AppSpacing.md }) {
      Row() {
        Text('Add a comment...')
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.outline)
          .opacity(0.85)
      }
      .height(64)
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .borderRadius(24)
      .backgroundColor(AppColors.surfaceVariant)
      .alignItems(VerticalAlign.Center)

      Button('POST', { type: ButtonType.Normal, stateEffect: true })
        .width(140)
        .height(64)
        .borderRadius(28)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height(96)
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct Index {
  @State voteState: number = 1;

  build() {
    Column() {
      AppTopBar()

      Scroll() {
        Column() {
          PostCard({
            post: MAIN_POST,
            voteState: this.voteState,
            onVote: (value: number): void => {
              this.voteState = value;
            }
          })

          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.outline)
            .letterSpacing(0.5)
            .width('100%')
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.lg,
              bottom: AppSpacing.sm
            })

          ForEach(REPLIES, (reply: Reply) => {
            ReplyCard({ reply: reply })
          }, (reply: Reply) => `${reply.id}`)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.background)

      BottomCommentBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}