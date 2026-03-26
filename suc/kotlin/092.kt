package com.example.myapplication

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Info
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Divider
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Enable Edge-to-Edge
        enableEdgeToEdge()

        // Hide System Bars for Immersive Mode
        val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
        windowInsetsController.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())

        setContent {
            // Apply a side effect to ensure bars stay hidden if the user swipes
            SideEffect {
                windowInsetsController.hide(WindowInsetsCompat.Type.systemBars())
            }

            ZenBonsaiApp()
        }
    }
}

// --- Color Palette (Custom Muted Earth Tones) ---
val ZenGreen = Color(0xFF6A8E6A)
val ZenGreenLight = Color(0xFFE8F5E9)
val ZenBrown = Color(0xFF8D6E63)
val ZenTextPrimary = Color(0xFF2C3E50)
val ZenTextSecondary = Color(0xFF7F8C8D)
val ZenWhite = Color(0xFFFFFFFF)
val ZenAccent = Color(0xFFD4E157)

@Composable
fun ZenBonsaiApp() {
    MaterialTheme(
        colorScheme = androidx.compose.material3.lightColorScheme(
            background = ZenWhite,
            surface = ZenWhite,
            primary = ZenGreen,
            onSurface = ZenTextPrimary
        )
    ) {
        // Main Container
        Scaffold(
            containerColor = ZenWhite,
            bottomBar = { SimpleBottomNav() }
        ) { paddingValues ->
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(paddingValues)
                    .padding(24.dp),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                // Header
                HeaderSection()

                Spacer(modifier = Modifier.height(32.dp))

                // Hero Image (Custom Drawing)
                BonsaiVisual(modifier = Modifier.size(220.dp))

                Spacer(modifier = Modifier.height(32.dp))

                // Status Cards
                StatusRow()

                Spacer(modifier = Modifier.height(32.dp))

                // Recent Activity
                ActivityLogSection()
            }
        }
    }
}

@Composable
fun HeaderSection() {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Text(
            text = "JUNIPER · #04",
            style = MaterialTheme.typography.labelMedium,
            color = ZenTextSecondary,
            letterSpacing = 2.sp
        )
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            text = "Zen Garden",
            style = MaterialTheme.typography.displaySmall.copy(
                fontWeight = FontWeight.Light,
                color = ZenTextPrimary
            )
        )
    }
}

@Composable
fun StatusRow() {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceEvenly
    ) {
        StatusItem(
            icon = Icons.Default.Favorite,
            label = "Health",
            value = "98%",
            tint = Color(0xFFE57373)
        )
        StatusItem(
            icon = Icons.Default.DateRange,
            label = "Age",
            value = "4 Yrs",
            tint = ZenBrown
        )
        StatusItem(
            icon = Icons.Default.CheckCircle,
            label = "Water",
            value = "2 Days",
            tint = Color(0xFF64B5F6)
        )
    }
}

@Composable
fun StatusItem(icon: androidx.compose.ui.graphics.vector.ImageVector, label: String, value: String, tint: Color) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Box(
            modifier = Modifier
                .size(50.dp)
                .background(Color(0xFFF7F9F9), CircleShape)
                .border(1.dp, Color(0xFFECEFF1), CircleShape),
            contentAlignment = Alignment.Center
        ) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                tint = tint,
                modifier = Modifier.size(24.dp)
            )
        }
        Spacer(modifier = Modifier.height(8.dp))
        Text(
            text = value,
            style = MaterialTheme.typography.titleMedium,
            fontWeight = FontWeight.Bold,
            color = ZenTextPrimary
        )
        Text(
            text = label,
            style = MaterialTheme.typography.labelSmall,
            color = ZenTextSecondary
        )
    }
}

@Composable
fun ActivityLogSection() {
    Column(modifier = Modifier.fillMaxWidth()) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = "Care Schedule",
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold
            )
            Icon(
                imageVector = Icons.Default.Add,
                contentDescription = "Add Log",
                tint = ZenGreen,
                modifier = Modifier
                    .size(28.dp)
                    .background(ZenGreenLight, CircleShape)
                    .padding(4.dp)
                    .clickable { }
            )
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Simple List Items
        CareLogItem(
            title = "Watering",
            subtitle = "Today, 8:00 AM",
            isDone = true
        )
        Spacer(modifier = Modifier.height(12.dp))
        CareLogItem(
            title = "Pruning",
            subtitle = "Tomorrow",
            isDone = false
        )
        Spacer(modifier = Modifier.height(12.dp))
        CareLogItem(
            title = "Fertilizer",
            subtitle = "In 5 days",
            isDone = false
        )
    }
}

@Composable
fun CareLogItem(title: String, subtitle: String, isDone: Boolean) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color(0xFFFAFAFA), RoundedCornerShape(12.dp))
            .border(1.dp, Color(0xFFF0F0F0), RoundedCornerShape(12.dp))
            .padding(16.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(12.dp)
                .background(
                    if (isDone) ZenGreen else Color(0xFFE0E0E0),
                    CircleShape
                )
        )
        Spacer(modifier = Modifier.width(16.dp))
        Column(modifier = Modifier.weight(1f)) {
            Text(
                text = title,
                style = MaterialTheme.typography.bodyMedium,
                color = if (isDone) ZenTextPrimary else ZenTextSecondary
            )
            Text(
                text = subtitle,
                style = MaterialTheme.typography.labelSmall,
                color = Color(0xFF9E9E9E)
            )
        }
        if (isDone) {
            Icon(
                imageVector = Icons.Default.Check,
                contentDescription = null,
                tint = ZenGreen,
                modifier = Modifier.size(20.dp)
            )
        }
    }
}

@Composable
fun SimpleBottomNav() {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .height(80.dp)
            .background(ZenWhite)
            .border(width = 1.dp, color = Color(0xFFF5F5F5)),
        horizontalArrangement = Arrangement.SpaceAround,
        verticalAlignment = Alignment.CenterVertically
    ) {
        NavIcon(Icons.Default.Home, true)
        NavIcon(Icons.Default.Info, false)
        NavIcon(Icons.Default.Settings, false)
    }
}

@Composable
fun NavIcon(icon: androidx.compose.ui.graphics.vector.ImageVector, isSelected: Boolean) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Icon(
            imageVector = icon,
            contentDescription = null,
            tint = if (isSelected) ZenGreen else Color(0xFFCFD8DC),
            modifier = Modifier.size(28.dp)
        )
        if (isSelected) {
            Spacer(modifier = Modifier.height(4.dp))
            Box(
                modifier = Modifier
                    .size(4.dp)
                    .background(ZenGreen, CircleShape)
            )
        }
    }
}

// --- Custom Art Logic (To avoid image resources) ---
@Composable
fun BonsaiVisual(modifier: Modifier = Modifier) {
    Box(
        modifier = modifier,
        contentAlignment = Alignment.BottomCenter
    ) {
        Canvas(modifier = Modifier.fillMaxSize()) {
            val w = size.width
            val h = size.height

            // 1. Draw Pot
            val potWidth = w * 0.5f
            val potHeight = h * 0.15f
            val potTop = h * 0.85f

            drawRect(
                color = ZenBrown,
                topLeft = Offset((w - potWidth) / 2, potTop),
                size = Size(potWidth, potHeight)
            )
            // Pot Rim
            drawRect(
                color = ZenBrown.copy(alpha = 0.8f),
                topLeft = Offset((w - potWidth) / 2 - 10f, potTop),
                size = Size(potWidth + 20f, 15f)
            )

            // 2. Draw Trunk (Bezier curves)
            val trunkPath = Path().apply {
                moveTo(w * 0.5f, potTop) // Base center
                // Curve up and left
                quadraticBezierTo(
                    w * 0.45f, h * 0.6f, // Control
                    w * 0.35f, h * 0.5f  // Point
                )
                // Curve right
                quadraticBezierTo(
                    w * 0.4f, h * 0.35f,
                    w * 0.6f, h * 0.3f
                )
            }

            drawPath(
                path = trunkPath,
                color = Color(0xFF5D4037),
                style = Stroke(width = 25f, cap = StrokeCap.Round)
            )

            // Secondary Branch
            drawLine(
                color = Color(0xFF5D4037),
                start = Offset(w * 0.38f, h * 0.55f),
                end = Offset(w * 0.25f, h * 0.45f),
                strokeWidth = 15f,
                cap = StrokeCap.Round
            )

            // 3. Draw Leaves (Clusters of circles)
            // Cluster 1 (Top Right)
            drawCircle(color = ZenGreen, radius = 45f, center = Offset(w * 0.6f, h * 0.25f))
            drawCircle(color = ZenGreen.copy(alpha = 0.8f), radius = 35f, center = Offset(w * 0.68f, h * 0.28f))
            drawCircle(color = ZenGreen.copy(alpha = 0.9f), radius = 30f, center = Offset(w * 0.55f, h * 0.22f))

            // Cluster 2 (Middle Left)
            drawCircle(color = ZenGreen, radius = 35f, center = Offset(w * 0.35f, h * 0.5f))
            drawCircle(color = ZenGreen.copy(alpha = 0.8f), radius = 25f, center = Offset(w * 0.30f, h * 0.45f))

            // Cluster 3 (Far Left Branch)
            drawCircle(color = ZenGreen, radius = 25f, center = Offset(w * 0.22f, h * 0.42f))
        }
    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    ZenBonsaiApp()
}