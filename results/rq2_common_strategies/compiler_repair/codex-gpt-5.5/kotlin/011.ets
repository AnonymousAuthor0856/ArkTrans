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

class ForumPost {
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

class ForumColors {
  static primary: string = '#00E5FF';
  static secondary: string = '#FF00AA';
  static tertiary: string = '#76FF03';
  static background: string = '#101024';
  static surface: string = '#1C1C3A';
  static surfaceVariant: string = '#282850';
  static outline: string = '#44446A';
  static warning: string = '#FFD600';
  static onPrimary: string = '#000000';
  static onSurface: string = '#E0E0FF';
}

@Entry
@Component
struct Index {
  @State voteState: number = 1;

  private post: ForumPost = new ForumPost(
    new Author('user/compose_master', ForumColors.tertiary),
    '8 hours ago',
    'The power of Jetpack Compose for single-file UIs',
    'Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?',
    1337,
    42
  );

  private replies: Reply[] = [
    new Reply(1, new Author('dev/android_fan', ForumColors.secondary), '7h ago', 'Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.', 25),
    new Reply(2, new Author('ux/designer_jane', ForumColors.primary), '5h ago', 'From a design perspective, having the design tokens and theme right next to the UI components is a game-changer for consistency.', 18),
    new Reply(3, new Author('newbie/coder', ForumColors.warning), '2h ago', 'I found it a bit overwhelming at first. Any tips for organizing the file?', 3)
  ];

  private score(): string {
    return (this.post.votes + this.voteState - 1).toString();
  }

  @Builder
  ArrowButton(label: string, active: boolean, activeColor: string, action: () => void) {
    Text(label)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .fontColor(active ? activeColor : ForumColors.outline)
      .width(36)
      .height(32)
      .textAlign(TextAlign.Center)
      .onClick(action)
  }

  @Builder
  AuthorInfo(author: Author, timestamp: string) {
    Row({ space: 8 }) {
      Stack() {
        Text('')
          .width(10)
          .height(10)
          .backgroundColor('#33000000')
          .borderRadius(10)
      }
      .width(24)
      .height(24)
      .backgroundColor(author.avatarColor)
      .borderRadius(24)
      .alignContent(Alignment.Center)
      Text(author.name)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(author.avatarColor)
        .lineHeight(18)
      Text(timestamp)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(ForumColors.outline)
        .lineHeight(18)
    }
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoChip(text: string) {
    Text(text)
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontColor(ForumColors.outline)
      .lineHeight(18)
  }

  @Builder
  PostCard() {
    Row({ space: 12 }) {
      Column({ space: 8 }) {
        this.ArrowButton('▲', this.voteState === 1, ForumColors.secondary, () => {
          this.voteState = this.voteState === 1 ? 0 : 1;
        })
        Text(this.score())
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.voteState !== 0 ? ForumColors.secondary : ForumColors.onSurface)
          .lineHeight(24)
        this.ArrowButton('▼', this.voteState === -1, ForumColors.primary, () => {
          this.voteState = this.voteState === -1 ? 0 : -1;
        })
      }
      .alignItems(HorizontalAlign.Center)

      Column({ space: 8 }) {
        this.AuthorInfo(this.post.author, this.post.timestamp)
        Text(this.post.title)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(ForumColors.onSurface)
          .lineHeight(28)
        Text(this.post.body)
          .fontSize(16)
          .fontColor('#CCE0E0FF')
          .lineHeight(24)
        Blank().height(8)
        Row({ space: 24 }) {
          this.InfoChip(this.post.commentCount.toString() + ' Comments')
          this.InfoChip('Share')
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ForumColors.surface)
  }

  @Builder
  ReplyCard(reply: Reply) {
    Row({ space: 12 }) {
      Text('')
        .width(2)
        .height(96)
        .backgroundColor(reply.author.avatarColor)
        .opacity(0.5)
        .borderRadius(2)
      Column({ space: 4 }) {
        this.AuthorInfo(reply.author, reply.timestamp)
        Text(reply.text)
          .fontSize(16)
          .fontColor('#E6E0E0FF')
          .lineHeight(24)
        Row({ space: 12 }) {
          this.InfoChip(reply.votes.toString() + ' votes')
          this.InfoChip('Reply')
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
  }

  @Builder
  CommentBar() {
    Row({ space: 12 }) {
      Stack() {
        Text('Add a comment...')
          .fontSize(16)
          .fontColor(ForumColors.outline)
          .lineHeight(24)
      }
      .height(48)
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
      .backgroundColor(ForumColors.surfaceVariant)
      .borderRadius(16)
      .alignContent(Alignment.Start)
      Button('POST')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(ForumColors.onPrimary)
        .backgroundColor(ForumColors.primary)
        .borderRadius(16)
        .height(48)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(ForumColors.surface)
    .shadow({ radius: 8, color: '#24000000', offsetX: 0, offsetY: -4 })
  }

  build() {
    Column() {
      Row() {
        Text('<')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(ForumColors.primary)
          .width(44)
          .textAlign(TextAlign.Center)
        Text('r/jetpackcompose')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ForumColors.onSurface)
          .lineHeight(24)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Blank().width(44)
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(ForumColors.surface)

      Scroll() {
        Column() {
          this.PostCard()
          Text('TOP COMMENTS')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(ForumColors.outline)
            .lineHeight(18)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          ForEach(this.replies, (reply: Reply) => {
            this.ReplyCard(reply)
          }, (reply: Reply) => reply.id.toString())
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .width('100%')

      this.CommentBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ForumColors.background)
  }
}
