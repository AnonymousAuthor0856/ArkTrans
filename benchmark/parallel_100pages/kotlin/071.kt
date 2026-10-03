package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.IconButton
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "163*QuizForge*en"
private const val UI_TYPE = "Quiz"
private const val STYLE_THEME = "Citrus Pop"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"
private const val COLOR_PALETTE = "primary:#FF8A2A secondary:#FFC857 tertiary:#68D672 background:#FFF9F2 surface:#FFFFFF surfaceVariant:#FFE4CC outline:#E2B088 success:#2AC28B warning:#FFB347 error:#F45B69 onPrimary:#2C0D00 onSecondary:#301A00 onTertiary:#083919 onBackground:#1E1205 onSurface:#311F10"
private const val DENSITY_SPACING = "Compact"
private const val COMPLEXITY = "QuestionCard,OptionChip,Progress"
private const val EXTRA = "Citrus quiz forge with cards, chips, and timed progress"

object DesignTokens {
    object Colors {
        val primary = Color(0xFFFF8A2A)
        val secondary = Color(0xFFFFC857)
        val tertiary = Color(0xFF68D672)
        val background = Color(0xFFFFF9F2)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFFFE4CC)
        val outline = Color(0xFFE2B088)
        val success = Color(0xFF2AC28B)
        val warning = Color(0xFFFFB347)
        val error = Color(0xFFF45B69)
        val onPrimary = Color(0xFF2C0D00)
        val onSecondary = Color(0xFF301A00)
        val onTertiary = Color(0xFF083919)
        val onBackground = Color(0xFF1E1205)
        val onSurface = Color(0xFF311F10)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 30.sp, fontWeight = FontWeight.Bold, lineHeight = 34.sp)
        val headline = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.SemiBold, lineHeight = 28.sp)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium, lineHeight = 22.sp)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, lineHeight = 20.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, lineHeight = 16.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(10.dp)
        val medium = RoundedCornerShape(18.dp)
        val large = RoundedCornerShape(28.dp)
    }
    object Spacing {
        val xxs = 4.dp
        val xs = 8.dp
        val sm = 12.dp
        val md = 16.dp
        val lg = 20.dp
        val xl = 28.dp
        val xxl = 36.dp
        val xxxl = 46.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.18f)
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.22f)
        val level3 = ShadowSpec(12.dp, 12.dp, 6.dp, 0.26f)
        val level4 = ShadowSpec(18.dp, 18.dp, 8.dp, 0.3f)
        val level5 = ShadowSpec(26.dp, 26.dp, 12.dp, 0.34f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = DesignTokens.Colors.primary,
    onPrimary = DesignTokens.Colors.onPrimary,
    secondary = DesignTokens.Colors.secondary,
    onSecondary = DesignTokens.Colors.onSecondary,
    tertiary = DesignTokens.Colors.tertiary,
    onTertiary = DesignTokens.Colors.onTertiary,
    background = DesignTokens.Colors.background,
    onBackground = DesignTokens.Colors.onBackground,
    surface = DesignTokens.Colors.surface,
    onSurface = DesignTokens.Colors.onSurface,
    surfaceVariant = DesignTokens.Colors.surfaceVariant,
    outline = DesignTokens.Colors.outline,
    error = DesignTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = DesignTokens.TypographyTokens.display,
    headlineMedium = DesignTokens.TypographyTokens.headline,
    titleMedium = DesignTokens.TypographyTokens.title,
    bodyMedium = DesignTokens.TypographyTokens.body,
    labelMedium = DesignTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            extraSmall = DesignTokens.Shapes.small,
            small = DesignTokens.Shapes.small,
            medium = DesignTokens.Shapes.medium,
            large = DesignTokens.Shapes.large,
            extraLarge = DesignTokens.Shapes.large
        ),
        content = content
    )
}

data class QuizQuestion(val category: String, val prompt: String, val options: List<String>, val hint: String)
data class StreakCard(val label: String, val value: String)

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                RootScreen()
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val question = QuizQuestion(
        category = "Citrus crafts",
        prompt = "Which zest carrier gives the brightest aroma when infused cold?",
        options = listOf("Dried peel sachet", "Twist garnish", "Zester microplane", "Candied strip"),
        hint = "Think surface area"
    )
    val streaks = listOf(
        StreakCard("Current streak", "5 days"),
        StreakCard("Accuracy", "84%"),
        StreakCard("Rank", "Top 12%")
    )
    var selectedIndex by remember { mutableStateOf(-1) }
    val progress = 0.45f
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        containerColor = MaterialTheme.colorScheme.background,
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        Text(text = "QuizForge", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "Aroma sprint", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                    }
                },
                navigationIcon = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(30.dp).clip(CircleShape).background(MaterialTheme.colorScheme.surfaceVariant))
                    }
                },
                actions = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(30.dp).clip(CircleShape).background(MaterialTheme.colorScheme.primary.copy(alpha = 0.35f)))
                    }
                }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .verticalScroll(rememberScrollState())
                .padding(horizontal = DesignTokens.Spacing.lg, vertical = DesignTokens.Spacing.sm),
            verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.md)
        ) {
            Surface(shape = DesignTokens.Shapes.large, tonalElevation = DesignTokens.ElevationMapping.level2.elevation) {
                Column(modifier = Modifier.padding(DesignTokens.Spacing.md), verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm)) {
                    Row(horizontalArrangement = Arrangement.SpaceBetween, modifier = Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                        Text(text = question.category, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "45%", style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.secondary)
                    }
                    LinearProgressIndicator(progress = { progress }, color = MaterialTheme.colorScheme.primary)
                    Text(text = question.prompt, style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    Column(verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xs)) {
                        question.options.forEachIndexed { index, option ->
                            val active = selectedIndex == index
                            Box(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .clip(DesignTokens.Shapes.medium)
                                    .background(if (active) MaterialTheme.colorScheme.primary.copy(alpha = 0.2f) else MaterialTheme.colorScheme.surfaceVariant)
                                    .border(1.dp, if (active) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.outline, DesignTokens.Shapes.medium)
                                    .padding(DesignTokens.Spacing.sm)
                                    .clickable { selectedIndex = index }
                            ) {
                                Text(text = option, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                            }
                        }
                    }
                    Box(
                        modifier = Modifier
                            .clip(DesignTokens.Shapes.small)
                            .background(MaterialTheme.colorScheme.secondary.copy(alpha = 0.2f))
                            .padding(horizontal = DesignTokens.Spacing.sm, vertical = DesignTokens.Spacing.xs)
                    ) {
                        Text(text = "Hint: ${question.hint}", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                    }
                }
            }
            Surface(shape = DesignTokens.Shapes.large, tonalElevation = DesignTokens.ElevationMapping.level1.elevation) {
                Column(modifier = Modifier.padding(DesignTokens.Spacing.md), verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xs)) {
                    Text(text = "Trackers", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    Row(horizontalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm)) {
                        streaks.forEach { streak ->
                            Column(
                                modifier = Modifier
                                    .weight(1f)
                                    .clip(DesignTokens.Shapes.medium)
                                    .background(MaterialTheme.colorScheme.surfaceVariant)
                                    .padding(DesignTokens.Spacing.sm),
                                verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xxs),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Text(text = streak.label, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                                Text(text = streak.value, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                            }
                        }
                    }
                    Button(onClick = {}, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary), shape = DesignTokens.Shapes.medium, modifier = Modifier.fillMaxWidth()) {
                        Text(text = "Submit answer", style = MaterialTheme.typography.titleMedium)
                    }
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewQuizForge() {
    AppTheme {
        RootScreen()
    }
}