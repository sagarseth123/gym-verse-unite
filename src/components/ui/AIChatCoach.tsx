import { useState, useRef } from 'react';
import { supabase } from '@/integrations/supabase/client';
import { Dialog, DialogContent, DialogHeader, DialogTitle } from './dialog';
import { Button } from './button';
import { Loader2, MessageCircle } from 'lucide-react';

export function AIChatCoach() {
  const [open, setOpen] = useState(false);
  const [messages, setMessages] = useState<{ role: 'user' | 'ai'; text: string }[]>([]);
  const [input, setInput] = useState('');
  const [loading, setLoading] = useState(false);
  const inputRef = useRef<HTMLInputElement>(null);

  const sendMessage = async () => {
    if (!input.trim()) return;
    
    const userMessage = input.trim();
    setMessages((prev) => [...prev, { role: 'user', text: userMessage }]);
    setLoading(true);
    setInput('');
    
    try {
      // Set a timeout to handle request timeout gracefully
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 5000); // 5 second timeout

      // Use direct fetch instead of supabase.functions.invoke to have more control
      const response = await fetch('http://127.0.0.1:54321/functions/v1/ai-chat-coach', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Origin': 'http://localhost:8080',
          'Authorization': `Bearer ${import.meta.env.VITE_SUPABASE_ANON_KEY || "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"}`
        },
        body: JSON.stringify({ prompt: userMessage }),
        signal: controller.signal,
        mode: 'cors', // Explicitly set CORS mode
      });
      
      // Clear the timeout since the request completed
      clearTimeout(timeoutId);
      
      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`Error ${response.status}: ${errorText}`);
      }
      
      const data = await response.json();
      if (data.error) {
        setMessages((prev) => [...prev, { role: 'ai', text: data.error || 'AI error' }]);
      } else {
        setMessages((prev) => [...prev, { role: 'ai', text: data.answer }]);
      }
    } catch (err: any) {
      console.error('AI Chat Error:', err);
      
      // Handle specific errors with friendly messages
      let errorMessage = 'Failed to get AI response.';
      
      if (err.name === 'AbortError') {
        errorMessage = 'The request timed out. The server might be busy. Please try again in a moment.';
      } else if (err.message.includes('NetworkError')) {
        errorMessage = 'Network error. Please check your connection and make sure the server is running.';
      } else if (err.message.includes('CORS')) {
        errorMessage = 'CORS error. There might be an issue with server configuration.';
      }
      
      setMessages((prev) => [...prev, { role: 'ai', text: errorMessage }]);
    } finally {
      setLoading(false);
      inputRef.current?.focus();
    }
  };

  return (
    <>
      {/* Floating Chat Button */}
      <button
        className="fixed bottom-6 right-6 z-50 bg-purple-600 hover:bg-purple-700 text-white rounded-full p-4 shadow-lg flex items-center gap-2"
        onClick={() => setOpen(true)}
        aria-label="Open AI Chat Coach"
      >
        <MessageCircle className="h-6 w-6" />
        <span className="hidden md:inline">AI Coach</span>
      </button>
      {/* Chat Modal */}
      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent className="max-w-lg">
          <DialogHeader>
            <DialogTitle>AI Chat Coach</DialogTitle>
            <div className="text-xs text-gray-500 mt-1">Ask anything about fitness, nutrition, or motivation!</div>
          </DialogHeader>
          <div className="flex flex-col h-96">
            <div className="flex-1 overflow-y-auto mb-4 bg-gray-50 rounded p-2">
              {messages.length === 0 ? (
                <div className="text-gray-400 text-center mt-16">Start the conversation!</div>
              ) : (
                messages.map((msg, idx) => (
                  <div key={idx} className={`mb-2 flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
                    <div className={`rounded-lg px-3 py-2 max-w-xs ${msg.role === 'user' ? 'bg-purple-600 text-white' : 'bg-white border text-gray-900'}`}>{msg.text}</div>
                  </div>
                ))
              )}
              {loading && (
                <div className="flex justify-start mb-2"><div className="rounded-lg px-3 py-2 bg-white border text-gray-900 flex items-center gap-2"><Loader2 className="h-4 w-4 animate-spin" /> AI is thinking...</div></div>
              )}
            </div>
            <div className="flex gap-2">
              <input
                ref={inputRef}
                type="text"
                className="flex-1 border rounded px-3 py-2 text-sm focus:outline-none focus:ring"
                placeholder="Type your question..."
                value={input}
                onChange={e => setInput(e.target.value)}
                onKeyDown={e => { if (e.key === 'Enter' && !loading) sendMessage(); }}
                disabled={loading}
                autoFocus
              />
              <Button onClick={sendMessage} disabled={loading || !input.trim()}>
                {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : <MessageCircle className="h-4 w-4" />}
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </>
  );
} 