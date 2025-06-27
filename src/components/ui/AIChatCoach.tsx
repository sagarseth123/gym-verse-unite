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
    setMessages((prev) => [...prev, { role: 'user', text: input }]);
    setLoading(true);
    setInput('');
    try {
      const { data, error } = await supabase.functions.invoke('ai-chat-coach', {
        body: { prompt: input },
      });
      if (error || data?.error) {
        setMessages((prev) => [...prev, { role: 'ai', text: data?.error || error.message || 'AI error' }]);
      } else {
        setMessages((prev) => [...prev, { role: 'ai', text: data.answer }]);
      }
    } catch (err: any) {
      setMessages((prev) => [...prev, { role: 'ai', text: err.message || 'Failed to get AI response.' }]);
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