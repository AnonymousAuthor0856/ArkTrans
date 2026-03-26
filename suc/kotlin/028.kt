package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "029_OCRCheckProductivityForm_en"
private const val UI_TYPE = "Dashboard"
private const val STYLE_THEME = "Monochrome Comfortable"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF0F172A)
        val secondary = Color(0xFF475569)
        val tertiary = Color(0xFF94A3B8)
        val background = Color(0xFFF8FAFC)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFF1F5F9)
        val outline = Color(0xFFE2E8F0)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFF0F172A)
        val onBackground = Color(0xFF0F172A)
        val onSurface = Color(0xFF0F172A)
    }

    object TypographyTokens {
        val display = TextStyle(fontSize = 32.sp, fontWeight = FontWeight.Bold, lineHeight = 40.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 24.sp, fontWeight = FontWeight.SemiBold, lineHeight = 32.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium, lineHeight = 24.sp, letterSpacing = 0.15.sp)
        val body = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Normal, lineHeight = 22.sp, letterSpacing = 0.5.sp)
        val label = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, lineHeight = 18.sp, letterSpacing = 0.5.sp)
    }

    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(12.dp)
        val large = RoundedCornerShape(16.dp)
    }

    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 16.dp
        val lg = 24.dp
        val xl = 32.dp
        val xxl = 48.dp
    }

    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 3.dp, 1.dp, 0.10f)
        val level2 = ShadowSpec(3.dp, 6.dp, 2.dp, 0.10f)
        val level3 = ShadowSpec(6.dp, 10.dp, 4.dp, 0.10f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class ProductivityItem(val id: Int, val title: String, val status: String, val progress: Float, val statusColor: Color)
data class ChartData(val label: String, val value: Float)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val filters = listOf("Daily", "Weekly", "Monthly")
    val selectedFilter = remember { mutableStateOf("Weekly") }

    val productivityItems = remember {
        listOf(
            ProductivityItem(1, "Form Batch #A-102", "Completed", 1.0f, AppTokens.Colors.success),
            ProductivityItem(2, "Invoice Set #B-231", "In Progress", 0.75f, AppTokens.Colors.warning),
            ProductivityItem(3, "Document Scan #C-456", "Pending", 0.1f, AppTokens.Colors.secondary),
            ProductivityItem(4, "Form Batch #A-103", "Completed", 1.0f, AppTokens.Colors.success),
            ProductivityItem(5, "Data Entry #D-789", "Failed", 0.4f, AppTokens.Colors.error)
        )
    }

    val chartData = remember {
        listOf(
            ChartData("Mon", 0.6f), ChartData("Tue", 0.8f), ChartData("Wed", 0.5f),
            ChartData("Thu", 1.0f), ChartData("Fri", 0.7f), ChartData("Sat", 0.4f),
            ChartData("Sun", 0.2f)
        )
    }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        containerColor = AppTokens.Colors.background,
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Productivity Check", style = MaterialTheme.typography.headlineMedium) },
                navigationIcon = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(24.dp).background(AppTokens.Colors.outline, CircleShape))
                    }
                },
                actions = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(24.dp).background(AppTokens.Colors.outline, CircleShape))
                    }
                },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(
                    containerColor = AppTokens.Colors.surface
                )
            )
        },
        bottomBar = {
            Surface(
                color = AppTokens.Colors.surface,
                tonalElevation = AppTokens.ElevationMapping.level3.elevation,
                shadowElevation = AppTokens.ElevationMapping.level3.elevation,
            ) {
                Button(
                    onClick = {},
                    modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.md).height(56.dp),
                    shape = AppTokens.Shapes.medium,
                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary)
                ) {
                    Text("Submit New Form", style = MaterialTheme.typography.titleMedium)
                }
            }
        }
    ) { paddingValues ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(paddingValues),
            contentPadding = PaddingValues(AppTokens.Spacing.md),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            item {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.Center
                ) {
                    filters.forEach { filter ->
                        val isSelected = selectedFilter.value == filter
                        FilterChip(
                            selected = isSelected,
                            onClick = { selectedFilter.value = filter },
                            label = { Text(filter, style = MaterialTheme.typography.labelMedium) },
                            shape = AppTokens.Shapes.small,
                            colors = FilterChipDefaults.filterChipColors(
                                selectedContainerColor = AppTokens.Colors.primary,
                                selectedLabelColor = AppTokens.Colors.onPrimary,
                                containerColor = AppTokens.Colors.surface,
                                labelColor = AppTokens.Colors.onSurface
                            ),
                            border = BorderStroke(1.dp, AppTokens.Colors.outline)
                        )
                        Spacer(modifier = Modifier.width(AppTokens.Spacing.sm))
                    }
                }
            }

            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = AppTokens.Shapes.large,
                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                    elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation)
                ) {
                    Column(modifier = Modifier.padding(AppTokens.Spacing.md)) {
                        Text("Weekly Throughput", style = MaterialTheme.typography.titleMedium)
                        Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
                        Column(modifier = Modifier.fillMaxWidth().height(150.dp)) {
                            Row(
                                modifier = Modifier.fillMaxWidth().weight(1f),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.Bottom
                            ) {
                                chartData.forEach { data ->
                                    Box(
                                        modifier = Modifier.weight(1f),
                                        contentAlignment = Alignment.BottomCenter
                                    ) {
                                        Box(
                                            modifier = Modifier
                                                .fillMaxWidth(0.6f)
                                                .fillMaxHeight(data.value)
                                                .background(AppTokens.Colors.primary, AppTokens.Shapes.small)
                                        )
                                    }
                                }
                            }
                            Spacer(modifier = Modifier.height(AppTokens.Spacing.sm))
                            Row(modifier = Modifier.fillMaxWidth()) {
                                chartData.forEach { data ->
                                    Text(
                                        text = data.label,
                                        style = MaterialTheme.typography.labelMedium,
                                        textAlign = TextAlign.Center,
                                        color = AppTokens.Colors.secondary,
                                        modifier = Modifier.weight(1f)
                                    )
                                }
                            }
                        }
                    }
                }
            }

            items(productivityItems) { item ->
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    shape = AppTokens.Shapes.medium,
                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                    border = BorderStroke(1.dp, AppTokens.Colors.outline),
                    elevation = CardDefaults.cardElevation(defaultElevation = 0.dp)
                ) {
                    Column(modifier = Modifier.padding(AppTokens.Spacing.md)) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.SpaceBetween
                        ) {
                            Text(item.title, style = MaterialTheme.typography.titleMedium)
                            Row(
                                verticalAlignment = Alignment.CenterVertically,
                                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                            ) {
                                Box(
                                    modifier = Modifier
                                        .size(10.dp)
                                        .background(item.statusColor, CircleShape)
                                )
                                Text(
                                    text = item.status,
                                    style = MaterialTheme.typography.labelMedium,
                                    color = item.statusColor
                                )
                            }
                        }
                        Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
                        Row(
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                        ) {
                            LinearProgressIndicator(
                                progress = { item.progress },
                                modifier = Modifier.weight(1f).height(8.dp).clip(CircleShape),
                                color = item.statusColor,
                                trackColor = AppTokens.Colors.surfaceVariant
                            )
                            Text(
                                text = "${(item.progress * 100).toInt()}%",
                                style = MaterialTheme.typography.labelMedium,
                                color = AppTokens.Colors.secondary,
                                textAlign = TextAlign.End,
                                modifier = Modifier.width(40.dp)
                            )
                        }
                    }
                }
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
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

@Preview(showBackground = true, widthDp = 360, heightDp = 720)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}